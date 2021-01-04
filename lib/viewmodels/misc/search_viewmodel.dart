import 'package:lolly_flutter/main.dart';

class SearchViewModel {
  var word = "";
  String get currentUrl => vmSettings.selectedDictReference
      .urlString(word, vmSettings.lstAutoCorrect);

  SearchViewModel() {}
}
