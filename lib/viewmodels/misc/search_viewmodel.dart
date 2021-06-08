import 'package:lolly_flutter/main.dart';

class IOnlineDict {
  String get getWord => '';
  String get getUrl => '';
}

class SearchViewModel implements IOnlineDict {
  var word = "";
  String get getWord => word;
  String get getUrl => vmSettings.selectedDictReference
      ?.urlString(word, vmSettings.lstAutoCorrect) ?? "";

  SearchViewModel();
}
