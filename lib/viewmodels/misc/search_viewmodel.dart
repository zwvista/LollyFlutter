class IOnlineDict {
  String get getWord => '';
}

class SearchViewModel implements IOnlineDict {
  var word = "";
  @override
  String get getWord => word;
}
