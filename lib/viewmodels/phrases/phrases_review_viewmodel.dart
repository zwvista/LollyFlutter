import 'dart:async';
import 'dart:math';

import 'package:lolly_flutter/models/misc/mreviewoptions.dart';
import 'package:lolly_flutter/models/wpp/munitphrase.dart';
import 'package:lolly_flutter/services/wpp/unit_phrase_service.dart';
import 'package:rx_command/rx_command.dart';

import '../../main.dart';

class PhrasesReviewViewModel {
  final unitPhraseService = UnitPhraseService();

  var items = <MUnitPhrase>[];
  int get count => items.length;
  var correctIDs = <int>[];
  int index = 0;
  bool get hasCurrent =>
      items.isNotEmpty && (onRepeat || (index >= 0 && index < count));
  MUnitPhrase? get currentItem => hasCurrent ? items[index] : null;
  String get currentPhrase => hasCurrent ? items[index].phrase : "";
  bool get isTestMode =>
      options.mode == ReviewMode.Test || options.mode == ReviewMode.Textbook;
  var options = MReviewOptions();
  Timer? subscriptionTimer;
  void Function() doTestAction;
  final isSpeaking_ =
      RxCommand.createSync((bool b) => b, initialLastResult: false);
  bool get isSpeaking => isSpeaking_.lastResult!;
  final indexString_ =
      RxCommand.createSync((String s) => s, initialLastResult: "");
  String get indexString => indexString_.lastResult!;
  set indexString(String value) => indexString_(value);
  final indexVisible_ =
      RxCommand.createSync((bool b) => b, initialLastResult: true);
  bool get indexVisible => indexVisible_.lastResult!;
  set indexVisible(bool value) => indexVisible_(value);
  final correctVisible_ =
      RxCommand.createSync((bool b) => b, initialLastResult: false);
  bool get correctVisible => correctVisible_.lastResult!;
  set correctVisible(bool value) => correctVisible_(value);
  final incorrectVisible_ =
      RxCommand.createSync((bool b) => b, initialLastResult: false);
  bool get incorrectVisible => incorrectVisible_.lastResult!;
  set incorrectVisible(bool value) => incorrectVisible_(value);
  final checkNextEnabled_ =
      RxCommand.createSync((bool b) => b, initialLastResult: false);
  bool get checkNextEnabled => checkNextEnabled_.lastResult!;
  set checkNextEnabled(bool value) => checkNextEnabled_(value);
  final checkNextString_ =
      RxCommand.createSync((String s) => s, initialLastResult: "Check");
  String get checkNextString => checkNextString_.lastResult!;
  set checkNextString(String value) => checkNextString_(value);
  final checkPrevEnabled_ =
      RxCommand.createSync((bool b) => b, initialLastResult: false);
  bool get checkPrevEnabled => checkPrevEnabled_.lastResult!;
  set checkPrevEnabled(bool value) => checkPrevEnabled_(value);
  final checkPrevString_ =
      RxCommand.createSync((String s) => s, initialLastResult: "Check");
  String get checkPrevString => checkPrevString_.lastResult!;
  set checkPrevString(String value) => checkPrevString_(value);
  final checkPrevVisible_ =
      RxCommand.createSync((bool b) => b, initialLastResult: true);
  bool get checkPrevVisible => checkPrevVisible_.lastResult!;
  set checkPrevVisible(bool value) => checkPrevVisible_(value);
  final phraseTargetString_ =
      RxCommand.createSync((String s) => s, initialLastResult: "");
  String get phraseTargetString => phraseTargetString_.lastResult!;
  set phraseTargetString(String value) => phraseTargetString_(value);
  final phraseTargetVisible_ =
      RxCommand.createSync((bool b) => b, initialLastResult: true);
  bool get phraseTargetVisible => phraseTargetVisible_.lastResult!;
  set phraseTargetVisible(bool value) => phraseTargetVisible_(value);
  final translationString_ =
      RxCommand.createSync((String s) => s, initialLastResult: "");
  String get translationString => translationString_.lastResult!;
  set translationString(String value) => translationString_(value);
  final phraseInputString_ =
      RxCommand.createSync((String s) => s, initialLastResult: "");
  String get phraseInputString => phraseInputString_.lastResult!;
  set phraseInputString(String value) => phraseInputString_(value);
  final moveForward_ =
      RxCommand.createSync((bool b) => b, initialLastResult: true);
  bool get moveForward => moveForward_.lastResult!;
  set moveForward(bool value) => moveForward_(value);
  final onRepeat_ =
      RxCommand.createSync((bool b) => b, initialLastResult: true);
  bool get onRepeat => onRepeat_.lastResult!;
  set onRepeat(bool value) => onRepeat_(value);
  final moveForwardVisible_ =
      RxCommand.createSync((bool b) => b, initialLastResult: true);
  bool get moveForwardVisible => moveForwardVisible_.lastResult!;
  set moveForwardVisible(bool value) => moveForwardVisible_(value);
  final onRepeatVisible_ =
      RxCommand.createSync((bool b) => b, initialLastResult: true);
  bool get onRepeatVisible => onRepeatVisible_.lastResult!;
  set onRepeatVisible(bool value) => onRepeatVisible_(value);

  PhrasesReviewViewModel(this.doTestAction);

  Future newTest() async {
    index = 0;
    items.clear();
    correctIDs.clear();
    subscriptionTimer?.cancel();
    isSpeaking_(options.speakingEnabled);
    moveForward_(options.moveForward);
    moveForwardVisible_(!isTestMode);
    onRepeat_(!isTestMode && options.onRepeat);
    onRepeatVisible_(!isTestMode);
    checkPrevVisible_(!isTestMode);
    if (options.mode == ReviewMode.Textbook) {
      var lst = await unitPhraseService
          .getDataByTextbook(vmSettings.selectedTextbook!);
      int cnt = min(options.reviewCount, lst.length);
      lst.shuffle();
      items = lst.sublist(0, cnt);
    } else {
      items = await unitPhraseService.getDataByTextbookUnitPart(
          vmSettings.selectedTextbook!,
          vmSettings.usunitpartfrom,
          vmSettings.usunitpartto);
      int nFrom = count * (options.groupSelected - 1) ~/ options.groupCount;
      int nTo = count * options.groupSelected ~/ options.groupCount;
      items = items.sublist(nFrom, nTo);
      if (options.shuffled) items.shuffle();
    }
    index = options.moveForward ? 0 : count - 1;
    doTest();
    checkNextString = isTestMode ? "Check" : "Next";
    checkPrevString = isTestMode ? "Check" : "Prev";
    if (options.mode == ReviewMode.ReviewAuto)
      subscriptionTimer = Timer.periodic(
          Duration(seconds: options.interval), (_) => check(true));
  }

  void move(bool toNext) {
    void checkOnRepeat() {
      if (onRepeat) index = (index + count) % count;
    }

    if (moveForward == toNext) {
      index++;
      if (isTestMode && !hasCurrent) {
        index = 0;
        items = items.where((o) => !correctIDs.contains(o.id)).toList();
      }
    } else {
      index--;
      checkOnRepeat();
    }
  }

  void check(bool toNext) {
    if (!isTestMode) {
      var b = true;
      if (options.mode == ReviewMode.ReviewManual &&
          phraseInputString.isNotEmpty &&
          phraseInputString != currentPhrase) {
        b = false;
        incorrectVisible = true;
      }
      if (b) {
        move(toNext);
        doTest();
      }
    } else if (!correctVisible && !incorrectVisible) {
      phraseInputString = vmSettings.autoCorrectInput(phraseInputString);
      phraseTargetVisible = true;
      if (phraseInputString == currentPhrase)
        correctVisible = true;
      else
        incorrectVisible = true;
      checkNextString = "Next";
      checkPrevString = "Prev";
      if (!hasCurrent) return;
      var o = currentItem!;
      var isCorrect = o.phrase == phraseInputString;
      if (isCorrect) correctIDs.add(o.id);
    } else {
      move(toNext);
      doTest();
      checkNextString = "Check";
      checkPrevString = "Check";
    }
  }

  void doTest() {
    indexVisible = hasCurrent;
    correctVisible = false;
    incorrectVisible = false;
    checkNextEnabled = hasCurrent;
    checkPrevEnabled = hasCurrent;
    phraseTargetString = currentPhrase;
    phraseTargetVisible = !isTestMode;
    translationString = currentItem?.translation ?? "";
    phraseInputString = "";
    doTestAction.call();
    if (hasCurrent)
      indexString = "${index + 1}/$count";
    else if (options.mode == ReviewMode.ReviewAuto) subscriptionTimer?.cancel();
  }
}
