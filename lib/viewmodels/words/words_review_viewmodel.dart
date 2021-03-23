import 'dart:async';

import 'package:lolly_flutter/models/misc/mdictionary.dart';
import 'package:lolly_flutter/models/misc/mreviewoptions.dart';
import 'package:lolly_flutter/models/wpp/munitword.dart';
import 'package:lolly_flutter/services/wpp/unit_word_service.dart';
import 'package:lolly_flutter/services/wpp/word_fami_service.dart';

import '../../main.dart';

class WordsReviewViewModel {
  final unitWordService = UnitWordService();
  final wordFamiService = WordFamiService();
  MDictionary get dictTranslation => vmSettings.selectedDictTranslation;

  List<MUnitWord> items;
  int get count => items.length;
  List<int> correctIDs;
  int index;
  bool get hasNext => index < count;
  MUnitWord get currentItem => hasNext ? items[index] : null;
  String get currentWord => hasNext ? items[index].word : "";
  bool get isTestMode =>
      options.mode == ReviewMode.Test || options.mode == ReviewMode.Textbook;
  MReviewOptions options = MReviewOptions();
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
}
