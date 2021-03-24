import 'dart:async';
import 'dart:math';

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
  MDictionary get dictTranslation => vmSettings.selectedDictTranslation;

  var items = <MUnitWord>[];
  int get count => items.length;
  var correctIDs = <int>[];
  int index;
  bool get hasNext => index < count;
  MUnitWord get currentItem => hasNext ? items[index] : null;
  String get currentWord => hasNext ? items[index].word : "";
  bool get isTestMode =>
      options.mode == ReviewMode.Test || options.mode == ReviewMode.Textbook;
  var options = MReviewOptions();
  Timer subscriptionTimer;
  void Function() doTestAction;
  var isSpeaking = false;
  var indexString = "";
  var indexIsVisible = true;
  var correctIsVisible = false;
  var incorrectIsVisible = false;
  var accuracyString = "";
  var accuracyIsVisible = true;
  var checkEnabled = false;
  var wordTargetString = "";
  var noteTargetString = "";
  var wordHintString = "";
  var wordHintIsVisible = false;
  var wordTargetIsVisible = true;
  var noteTargetIsVisible = true;
  var translationString = "";
  var wordInputString = "";
  var checkString = "Check";
  var searchEnabled = false;
  var googleEnabled = false;

  WordsReviewViewModel(this.doTestAction);

  Future newTest() async {
    subscriptionTimer?.cancel();
    if (options.mode == ReviewMode.Textbook) {
      var rand = Random();
      var lst =
          await unitWordService.getDataByTextbook(vmSettings.selectedTextbook);
      var lst2 = <MUnitWord>[];
      for (var o in lst) {
        var s = o.accuracy;
        double percentage = !s.endsWith("%")
            ? 0
            : double.parse(s.replaceFirst(RegExp(r"%$"), ""));
        int t = 6 - ((percentage / 20) as int);
        for (int i = 0; i < t; i++) lst2.add(o);
      }
      items = [];
      int cnt = min(options.reviewCount, lst.length);
      while (items.length < cnt) {
        var o = lst2[rand.nextInt(lst2.length)];
        if (!items.contains(o)) items.add(o);
      }
    } else {
      items = await unitWordService.getDataByTextbookUnitPart(
          vmSettings.selectedTextbook,
          vmSettings.usunitpartfrom,
          vmSettings.usunitpartto);
      int nFrom = count * (options.groupSelected - 1) ~/ options.groupCount;
      int nTo = count * options.groupSelected ~/ options.groupCount;
      items = items.sublist(nFrom, nTo);
      if (options.shuffled) items.shuffle();
    }
    correctIDs = [];
    index = 0;
    await doTest();
    checkString = isTestMode ? "Check" : "Next";
    if (options.mode == ReviewMode.ReviewAuto)
      subscriptionTimer = Timer.periodic(
          Duration(milliseconds: options.interval), (_) async => await check());
  }

  void next() {
    index++;
    if (isTestMode && !hasNext) {
      index = 0;
      items = items.where((o) => !correctIDs.contains(o.id)).toList();
    }
  }

  Future<String> getTranslation() async {
    if (dictTranslation == null) return "";
    var url = dictTranslation.urlString(currentWord, vmSettings.lstAutoCorrect);
    var html = await BaseService.getHtmlByUrl(url);
    return HtmlTransformService.extractTextFromHtml(
        html, dictTranslation.transform, "", (text, _) => text);
  }

  Future check() async {
    if (!isTestMode) {
      var b = true;
      if (options.mode == ReviewMode.ReviewManual &&
          wordInputString.isNotEmpty &&
          wordInputString != currentWord) {
        b = false;
        incorrectIsVisible = true;
      }
      if (b) {
        next();
        await doTest();
      }
    } else if (!correctIsVisible && !incorrectIsVisible) {
      wordInputString = vmSettings.autoCorrectInput(wordInputString);
      wordTargetIsVisible = true;
      noteTargetIsVisible = true;
      if (wordInputString == currentWord)
        correctIsVisible = true;
      else
        incorrectIsVisible = true;
      wordHintIsVisible = false;
      googleEnabled = searchEnabled = true;
      checkString = "Next";
      if (!hasNext) return;
      var o = currentItem;
      var isCorrect = o.word == wordInputString;
      if (isCorrect) correctIDs.add(o.id);
      var o2 = await wordFamiService.update(o.wordid, isCorrect);
      o.correct = o2.correct;
      o.total = o2.total;
      accuracyString = o.accuracy;
    } else {
      next();
      await doTest();
      checkString = "Check";
    }
  }

  Future doTest() async {
    indexIsVisible = hasNext;
    correctIsVisible = false;
    incorrectIsVisible = false;
    accuracyIsVisible = isTestMode && hasNext;
    checkEnabled = hasNext;
    wordTargetString = currentWord;
    noteTargetString = currentItem?.note;
    wordHintString = currentItem?.word.length.toString() ?? "";
    wordTargetIsVisible = !isTestMode;
    noteTargetIsVisible = !isTestMode;
    wordHintIsVisible = isTestMode;
    translationString = "";
    wordInputString = "";
    googleEnabled = searchEnabled = false;
    doTestAction?.call();
    if (hasNext) {
      indexString = "${index + 1}/$count";
      accuracyString = currentItem.accuracy;
      translationString = await getTranslation();
      if (translationString.isEmpty && !options.speakingEnabled)
        wordInputString = currentWord;
    } else if (options.mode == ReviewMode.ReviewAuto)
      subscriptionTimer?.cancel();
  }
}
