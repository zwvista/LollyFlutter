import 'package:json_annotation/json_annotation.dart';

part 'mpatternwebpage.g.dart';

@JsonSerializable()
class MPatternWebPages {
  @JsonKey(name: 'records')
  List<MPatternWebPage> lst;

  MPatternWebPages() {}
  factory MPatternWebPages.fromJson(Map<String, dynamic> json) =>
      _$MPatternWebPagesFromJson(json);
  Map<String, dynamic> toJson() => _$MPatternWebPagesToJson(this);
}

@JsonSerializable()
class MPatternWebPage {
  @JsonKey(name: 'ID')
  var id = 0;
  @JsonKey(name: 'PATTERNID')
  var patternid = 0;
  @JsonKey(name: 'LANGID')
  var langid = 0;
  @JsonKey(name: 'PATTERN')
  var pattern = "";
  @JsonKey(name: 'WEBPAGEID')
  var webpageid = 0;
  @JsonKey(name: 'SEQNUM')
  var seqnum = 0;
  @JsonKey(name: 'TITLE')
  var title = "";
  @JsonKey(name: 'URL')
  var url = "";

  MPatternWebPage() {}
  factory MPatternWebPage.fromJson(Map<String, dynamic> json) =>
      _$MPatternWebPageFromJson(json);
  Map<String, dynamic> toJson() => _$MPatternWebPageToJson(this);
}
