import 'dart:async';
import 'dart:math';

import 'package:flutter_command/flutter_command.dart';
import 'package:lolly_flutter/models/misc/mreviewoptions.dart';
import 'package:lolly_flutter/models/wpp/munitphrase.dart';
import 'package:lolly_flutter/services/wpp/unit_phrase_service.dart';

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
  final isSpeaking_ = Command.createSync((bool b) => b, initialValue: false);
  bool get isSpeaking => isSpeaking_.value;
  final indexString_ = Command.createSync((String s) => s, initialValue: "");
  String get indexString => indexString_.value;
  set indexString(String value) => indexString_(value);
  final indexVisible_ = Command.createSync((bool b) => b, initialValue: true);
  bool get indexVisible => indexVisible_.value;
  set indexVisible(bool value) => indexVisible_(value);
  final correctVisible_ =
      Command.createSync((bool b) => b, initialValue: false);
  bool get correctVisible => correctVisible_.value;
  set correctVisible(bool value) => correctVisible_(value);
  final incorrectVisible_ =
      Command.createSync((bool b) => b, initialValue: false);
  bool get incorrectVisible => incorrectVisible_.value;
  set incorrectVisible(bool value) => incorrectVisible_(value);
  final checkNextEnabled_ =
      Command.createSync((bool b) => b, initialValue: false);
  bool get checkNextEnabled => checkNextEnabled_.value;
  set checkNextEnabled(bool value) => checkNextEnabled_(value);
  final checkNextString_ =
      Command.createSync((String s) => s, initialValue: "Check");
  String get checkNextString => checkNextString_.value;
  set checkNextString(String value) => checkNextString_(value);
  final checkPrevEnabled_ =
      Command.createSync((bool b) => b, initialValue: false);
  bool get checkPrevEnabled => checkPrevEnabled_.value;
  set checkPrevEnabled(bool value) => checkPrevEnabled_(value);
  final checkPrevString_ =
      Command.createSync((String s) => s, initialValue: "Check");
  String get checkPrevString => checkPrevString_.value;
  set checkPrevString(String value) => checkPrevString_(value);
  final checkPrevVisible_ =
      Command.createSync((bool b) => b, initialValue: true);
  bool get checkPrevVisible => checkPrevVisible_.value;
  set checkPrevVisible(bool value) => checkPrevVisible_(value);
  final phraseTargetString_ =
      Command.createSync((String s) => s, initialValue: "");
  String get phraseTargetString => phraseTargetString_.value;
  set phraseTargetString(String value) => phraseTargetString_(value);
  final phraseTargetVisible_ =
      Command.createSync((bool b) => b, initialValue: true);
  bool get phraseTargetVisible => phraseTargetVisible_.value;
  set phraseTargetVisible(bool value) => phraseTargetVisible_(value);
  final translationString_ =
      Command.createSync((String s) => s, initialValue: "");
  String get translationString => translationString_.value;
  set translationString(String value) => translationString_(value);
  final phraseInputString_ =
      Command.createSync((String s) => s, initialValue: "");
  String get phraseInputString => phraseInputString_.value;
  set phraseInputString(String value) => phraseInputString_(value);
  final moveForward_ = Command.createSync((bool b) => b, initialValue: true);
  bool get moveForward => moveForward_.value;
  set moveForward(bool value) => moveForward_(value);
  final onRepeat_ = Command.createSync((bool b) => b, initialValue: true);
  bool get onRepeat => onRepeat_.value;
  set onRepeat(bool value) => onRepeat_(value);
  final moveForwardVisible_ =
      Command.createSync((bool b) => b, initialValue: true);
  bool get moveForwardVisible => moveForwardVisible_.value;
  set moveForwardVisible(bool value) => moveForwardVisible_(value);
  final onRepeatVisible_ =
      Command.createSync((bool b) => b, initialValue: true);
  bool get onRepeatVisible => onRepeatVisible_.value;
  set onRepeatVisible(bool value) => onRepeatVisible_(value);

  PhrasesReviewViewModel(this.doTestAction);

  Future<void> newTest() async {
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
    if (options.mode == ReviewMode.ReviewAuto) {
      subscriptionTimer = Timer.periodic(
          Duration(seconds: options.interval), (_) => check(true));
    }
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
      if (phraseInputString == currentPhrase) {
        correctVisible = true;
      } else {
        incorrectVisible = true;
      }
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
    if (hasCurrent) {
      indexString = "${index + 1}/$count";
    } else if (options.mode == ReviewMode.ReviewAuto) {
      subscriptionTimer?.cancel();
    }
  }
}
