import 'dart:async';
import 'dart:math';

import 'package:flutter_command/flutter_command.dart';
import 'package:lolly_flutter/models/misc/mdictionary.dart';
import 'package:lolly_flutter/models/misc/mreviewoptions.dart';
import 'package:lolly_flutter/models/wpp/munitword.dart';
import 'package:lolly_flutter/services/misc/base_service.dart';
import 'package:lolly_flutter/services/misc/html_transform_service.dart';
import 'package:lolly_flutter/services/wpp/unit_word_service.dart';
import 'package:lolly_flutter/services/wpp/word_fami_service.dart';

import '../../main.dart';

class WordsReviewViewModel {
  final unitWordService = UnitWordService();
  final wordFamiService = WordFamiService();
  MDictionary? get dictTranslation => vmSettings.selectedDictTranslation;

  var items = <MUnitWord>[];
  int get count => items.length;
  var correctIDs = <int>[];
  int index = 0;
  bool get hasCurrent =>
      items.isNotEmpty && (onRepeat || (index >= 0 && index < count));
  MUnitWord? get currentItem => hasCurrent ? items[index] : null;
  String get currentWord => hasCurrent ? items[index].word : "";
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
  final accuracyString_ = Command.createSync((String s) => s, initialValue: "");
  String get accuracyString => accuracyString_.value;
  set accuracyString(String value) => accuracyString_(value);
  final accuracyVisible_ =
      Command.createSync((bool b) => b, initialValue: true);
  bool get accuracyVisible => accuracyVisible_.value;
  set accuracyVisible(bool value) => accuracyVisible_(value);
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
  final checkPrevVisible_ =
      Command.createSync((bool b) => b, initialValue: true);
  bool get checkPrevVisible => checkPrevVisible_.value;
  set checkPrevVisible(bool value) => checkPrevVisible_(value);
  final checkPrevString_ =
      Command.createSync((String s) => s, initialValue: "Check");
  String get checkPrevString => checkPrevString_.value;
  set checkPrevString(String value) => checkPrevString_(value);
  final wordTargetString_ =
      Command.createSync((String s) => s, initialValue: "");
  String get wordTargetString => wordTargetString_.value;
  set wordTargetString(String value) => wordTargetString_(value);
  final noteTargetString_ =
      Command.createSync((String s) => s, initialValue: "");
  String get noteTargetString => noteTargetString_.value;
  set noteTargetString(String value) => noteTargetString_(value);
  final wordHintString_ = Command.createSync((String s) => s, initialValue: "");
  String get wordHintString => wordHintString_.value;
  set wordHintString(String value) => wordHintString_(value);
  final wordHintVisible_ =
      Command.createSync((bool b) => b, initialValue: false);
  bool get wordHintVisible => wordHintVisible_.value;
  set wordHintVisible(bool value) => wordHintVisible_(value);
  final wordTargetVisible_ =
      Command.createSync((bool b) => b, initialValue: true);
  bool get wordTargetVisible => wordTargetVisible_.value;
  set wordTargetVisible(bool value) => wordTargetVisible_(value);
  final noteTargetVisible_ =
      Command.createSync((bool b) => b, initialValue: true);
  bool get noteTargetVisible => noteTargetVisible_.value;
  set noteTargetVisible(bool value) => noteTargetVisible_(value);
  final translationString_ =
      Command.createSync((String s) => s, initialValue: "");
  String get translationString => translationString_.value;
  set translationString(String value) => translationString_(value);
  final wordInputString_ =
      Command.createSync((String s) => s, initialValue: "");
  String get wordInputString => wordInputString_.value;
  set wordInputString(String value) => wordInputString_(value);
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

  WordsReviewViewModel(this.doTestAction);

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
      var rand = Random();
      var lst =
          await unitWordService.getDataByTextbook(vmSettings.selectedTextbook!);
      var lst2 = <MUnitWord>[];
      for (var o in lst) {
        var s = o.accuracy;
        double percentage = !s.endsWith("%")
            ? 0
            : double.parse(s.replaceFirst(RegExp(r"%$"), ""));
        int t = 6 - ((percentage / 20) as int);
        for (int i = 0; i < t; i++) {
          lst2.add(o);
        }
      }
      items = [];
      int cnt = min(options.reviewCount, lst.length);
      while (items.length < cnt) {
        var o = lst2[rand.nextInt(lst2.length)];
        if (!items.contains(o)) items.add(o);
      }
    } else {
      items = await unitWordService.getDataByTextbookUnitPart(
          vmSettings.selectedTextbook!,
          vmSettings.usunitpartfrom,
          vmSettings.usunitpartto);
      int nFrom = count * (options.groupSelected - 1) ~/ options.groupCount;
      int nTo = count * options.groupSelected ~/ options.groupCount;
      items = items.sublist(nFrom, nTo);
      if (options.shuffled) items.shuffle();
    }
    index = options.moveForward ? 0 : count - 1;
    await doTest();
    checkNextString = isTestMode ? "Check" : "Next";
    checkPrevString = isTestMode ? "Check" : "Prev";
    if (options.mode == ReviewMode.ReviewAuto) {
      subscriptionTimer = Timer.periodic(
          Duration(seconds: options.interval), (_) async => await check(true));
    }
  }

  void move(bool toNext) {
    void checkOnRepeat() {
      if (onRepeat) index = (index + count) % count;
    }

    if (moveForward == toNext) {
      index++;
      checkOnRepeat();
      if (isTestMode && !hasCurrent) {
        index = 0;
        items = items.where((o) => !correctIDs.contains(o.id)).toList();
      }
    } else {
      index--;
      checkOnRepeat();
    }
  }

  Future<String> getTranslation() async {
    if (dictTranslation == null) return "";
    var url =
        dictTranslation!.urlString(currentWord, vmSettings.lstAutoCorrect);
    var html = await BaseService.getHtmlByUrl(url);
    return HtmlTransformService.extractTextFromHtml(
        html, dictTranslation!.transform, "", (text, _) => text);
  }

  Future<void> check(bool toNext) async {
    if (!isTestMode) {
      var b = true;
      if (options.mode == ReviewMode.ReviewManual &&
          wordInputString.isNotEmpty &&
          wordInputString != currentWord) {
        b = false;
        incorrectVisible = true;
      }
      if (b) {
        move(toNext);
        await doTest();
      }
    } else if (!correctVisible && !incorrectVisible) {
      wordInputString = vmSettings.autoCorrectInput(wordInputString);
      wordTargetVisible = true;
      noteTargetVisible = true;
      if (wordInputString == currentWord) {
        correctVisible = true;
      } else {
        incorrectVisible = true;
      }
      wordHintVisible = false;
      checkNextString = "Next";
      checkPrevString = "Prev";
      if (!hasCurrent) return;
      var o = currentItem!;
      var isCorrect = o.word == wordInputString;
      if (isCorrect) correctIDs.add(o.id);
      var o2 = await wordFamiService.update(o.wordid, isCorrect);
      o.correct = o2.correct;
      o.total = o2.total;
      accuracyString = o.accuracy;
    } else {
      move(toNext);
      await doTest();
      checkNextString = "Check";
      checkPrevString = "Check";
    }
  }

  Future<void> doTest() async {
    indexVisible = hasCurrent;
    correctVisible = false;
    incorrectVisible = false;
    accuracyVisible = isTestMode && hasCurrent;
    checkNextEnabled = hasCurrent;
    checkPrevEnabled = hasCurrent;
    wordTargetString = currentWord;
    noteTargetString = currentItem?.note ?? "";
    wordHintString = currentItem?.word.length.toString() ?? "";
    wordTargetVisible = !isTestMode;
    noteTargetVisible = !isTestMode;
    wordHintVisible = isTestMode;
    translationString = "";
    wordInputString = "";
    doTestAction.call();
    if (hasCurrent) {
      indexString = "${index + 1}/$count";
      accuracyString = currentItem!.accuracy;
      translationString = await getTranslation();
    } else if (options.mode == ReviewMode.ReviewAuto) {
      subscriptionTimer?.cancel();
    }
  }
}
