import 'package:lolly_flutter/main.dart';
import 'package:lolly_flutter/models/misc/mcommon.dart';
import 'package:lolly_flutter/viewmodels/misc/search_viewmodel.dart';

class WordsDictViewModel implements IOnlineDict {
  List<MSelectItem> lstWords;
  var currentWordIndex = 0;
  MSelectItem get currentWord => lstWords[currentWordIndex];
  String get getWord => currentWord.label;
  String get getUrl => vmSettings.selectedDictReference
      .urlString(currentWord.label, vmSettings.lstAutoCorrect);

  WordsDictViewModel(List<String> lstWords, int index) {
    this.lstWords = lstWords
        .asMap()
        .map((k, v) => MapEntry(k, MSelectItem(k, v)))
        .values
        .toList();
    currentWordIndex = index;
  }
  void setIndex(int index) {
    currentWordIndex = index;
  }

  void next(int delta) => currentWordIndex =
      (currentWordIndex + delta + lstWords.length) % lstWords.length;
}
