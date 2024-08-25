import 'package:lolly_flutter/main.dart';

class IOnlineDict {
  String get getWord => '';
  String get getUrl => '';
}

class SearchViewModel implements IOnlineDict {
  var word = "";
  @override
  String get getWord => word;
  @override
  String get getUrl =>
      vmSettings.selectedDictReference
          ?.urlString(word, vmSettings.lstAutoCorrect) ??
      "";

  SearchViewModel();
}
