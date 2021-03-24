import 'dart:async';
import 'dart:math';

import 'package:lolly_flutter/models/misc/mreviewoptions.dart';
import 'package:lolly_flutter/models/wpp/munitphrase.dart';
import 'package:lolly_flutter/services/wpp/unit_phrase_service.dart';

import '../../main.dart';

class PhrasesReviewViewModel {
  final unitPhraseService = UnitPhraseService();

  var items = <MUnitPhrase>[];
  int get count => items.length;
  var correctIDs = <int>[];
  int index;
  bool get hasNext => index < count;
  MUnitPhrase get currentItem => hasNext ? items[index] : null;
  String get currentPhrase => hasNext ? items[index].phrase : "";
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
  var checkEnabled = false;
  var phraseTargetString = "";
  var phraseTargetIsVisible = true;
  var translationString = "";
  var phraseInputString = "";
  var checkString = "Check";

  PhrasesReviewViewModel(this.doTestAction);

  Future newTest() async {
    subscriptionTimer?.cancel();
    if (options.mode == ReviewMode.Textbook) {
      var rand = Random();
      var lst = await unitPhraseService
          .getDataByTextbook(vmSettings.selectedTextbook);
      int cnt = min(options.reviewCount, lst.length);
      lst.shuffle();
      items = lst.sublist(0, cnt);
    } else {
      items = await unitPhraseService.getDataByTextbookUnitPart(
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
          Duration(milliseconds: options.interval), (_) => check());
  }

  void next() {
    index++;
    if (isTestMode && !hasNext) {
      index = 0;
      items = items.where((o) => !correctIDs.contains(o.id)).toList();
    }
  }

  void check() {
    if (!isTestMode) {
      var b = true;
      if (options.mode == ReviewMode.ReviewManual &&
          phraseInputString.isNotEmpty &&
          phraseInputString != currentPhrase) {
        b = false;
        incorrectIsVisible = true;
      }
      if (b) {
        next();
        doTest();
      }
    } else if (!correctIsVisible && !incorrectIsVisible) {
      phraseInputString = vmSettings.autoCorrectInput(phraseInputString);
      phraseTargetIsVisible = true;
      if (phraseInputString == currentPhrase)
        correctIsVisible = true;
      else
        incorrectIsVisible = true;
      checkString = "Next";
      if (!hasNext) return;
      var o = currentItem;
      var isCorrect = o.phrase == phraseInputString;
      if (isCorrect) correctIDs.add(o.id);
    } else {
      next();
      doTest();
      checkString = "Check";
    }
  }

  void doTest() {
    indexIsVisible = hasNext;
    correctIsVisible = false;
    incorrectIsVisible = false;
    checkEnabled = hasNext;
    phraseTargetString = currentPhrase;
    phraseTargetIsVisible = !isTestMode;
    translationString = currentItem?.translation;
    phraseInputString = "";
    doTestAction?.call();
    if (hasNext)
      indexString = "${index + 1}/$count";
    else if (options.mode == ReviewMode.ReviewAuto) subscriptionTimer?.cancel();
  }
}
