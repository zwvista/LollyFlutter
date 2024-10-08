import 'dart:async';
import 'dart:math';

import 'package:lolly_flutter/models/misc/mdictionary.dart';
import 'package:lolly_flutter/models/misc/mreviewoptions.dart';
import 'package:lolly_flutter/models/wpp/munitword.dart';
import 'package:lolly_flutter/services/misc/base_service.dart';
import 'package:lolly_flutter/services/misc/html_transform_service.dart';
import 'package:lolly_flutter/services/wpp/unit_word_service.dart';
import 'package:lolly_flutter/services/wpp/word_fami_service.dart';
import 'package:rx_command/rx_command.dart';

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
  final accuracyString_ =
      RxCommand.createSync((String s) => s, initialLastResult: "");
  String get accuracyString => accuracyString_.lastResult!;
  set accuracyString(String value) => accuracyString_(value);
  final accuracyVisible_ =
      RxCommand.createSync((bool b) => b, initialLastResult: true);
  bool get accuracyVisible => accuracyVisible_.lastResult!;
  set accuracyVisible(bool value) => accuracyVisible_(value);
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
  final checkPrevVisible_ =
      RxCommand.createSync((bool b) => b, initialLastResult: true);
  bool get checkPrevVisible => checkPrevVisible_.lastResult!;
  set checkPrevVisible(bool value) => checkPrevVisible_(value);
  final checkPrevString_ =
      RxCommand.createSync((String s) => s, initialLastResult: "Check");
  String get checkPrevString => checkPrevString_.lastResult!;
  set checkPrevString(String value) => checkPrevString_(value);
  final wordTargetString_ =
      RxCommand.createSync((String s) => s, initialLastResult: "");
  String get wordTargetString => wordTargetString_.lastResult!;
  set wordTargetString(String value) => wordTargetString_(value);
  final noteTargetString_ =
      RxCommand.createSync((String s) => s, initialLastResult: "");
  String get noteTargetString => noteTargetString_.lastResult!;
  set noteTargetString(String value) => noteTargetString_(value);
  final wordHintString_ =
      RxCommand.createSync((String s) => s, initialLastResult: "");
  String get wordHintString => wordHintString_.lastResult!;
  set wordHintString(String value) => wordHintString_(value);
  final wordHintVisible_ =
      RxCommand.createSync((bool b) => b, initialLastResult: false);
  bool get wordHintVisible => wordHintVisible_.lastResult!;
  set wordHintVisible(bool value) => wordHintVisible_(value);
  final wordTargetVisible_ =
      RxCommand.createSync((bool b) => b, initialLastResult: true);
  bool get wordTargetVisible => wordTargetVisible_.lastResult!;
  set wordTargetVisible(bool value) => wordTargetVisible_(value);
  final noteTargetVisible_ =
      RxCommand.createSync((bool b) => b, initialLastResult: true);
  bool get noteTargetVisible => noteTargetVisible_.lastResult!;
  set noteTargetVisible(bool value) => noteTargetVisible_(value);
  final translationString_ =
      RxCommand.createSync((String s) => s, initialLastResult: "");
  String get translationString => translationString_.lastResult!;
  set translationString(String value) => translationString_(value);
  final wordInputString_ =
      RxCommand.createSync((String s) => s, initialLastResult: "");
  String get wordInputString => wordInputString_.lastResult!;
  set wordInputString(String value) => wordInputString_(value);
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

  WordsReviewViewModel(this.doTestAction);

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

  Future check(bool toNext) async {
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

  Future doTest() async {
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
      if (translationString.isEmpty && !options.speakingEnabled) {
        wordInputString = currentWord;
      }
    } else if (options.mode == ReviewMode.ReviewAuto) {
      subscriptionTimer?.cancel();
    }
  }
}
