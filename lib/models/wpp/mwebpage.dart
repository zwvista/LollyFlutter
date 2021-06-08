import 'package:json_annotation/json_annotation.dart';

part 'mwebpage.g.dart';

@JsonSerializable()
class MWebPages {
  @JsonKey(name: 'records')
  List<MWebPage> lst = [];

  MWebPages();
  factory MWebPages.fromJson(Map<String, dynamic> json) =>
      _$MWebPagesFromJson(json);
  Map<String, dynamic> toJson() => _$MWebPagesToJson(this);
}

@JsonSerializable()
class MWebPage {
  @JsonKey(name: 'ID')
  var id = 0;
  @JsonKey(name: 'TITLE')
  var title = "";
  @JsonKey(name: 'URL')
  var url = "";

  MWebPage();
  factory MWebPage.fromJson(Map<String, dynamic> json) =>
      _$MWebPageFromJson(json);
  Map<String, dynamic> toJson() => _$MWebPageToJson(this);
}
