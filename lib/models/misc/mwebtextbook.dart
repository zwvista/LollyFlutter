import 'package:json_annotation/json_annotation.dart';

part 'mwebtextbook.g.dart';

@JsonSerializable()
class MWebTextbooks {
  @JsonKey(name: 'records')
  List<MWebTextbook> lst = [];

  MWebTextbooks();

  factory MWebTextbooks.fromJson(Map<String, dynamic> json) =>
      _$MWebTextbooksFromJson(json);

  Map<String, dynamic> toJson() => _$MWebTextbooksToJson(this);
}

@JsonSerializable()
class MWebTextbook {
  @JsonKey(name: 'ID')
  var id = 0;
  @JsonKey(name: 'LANGID')
  var langid = 0;
  @JsonKey(name: 'TEXTBOOKID')
  var textbookid = 0;
  @JsonKey(name: 'TEXTBOOKNAME')
  var textbookname = "";
  @JsonKey(name: 'UNIT')
  var unit = 0;
  @JsonKey(name: 'TITLE')
  var title = "";
  @JsonKey(name: 'URL')
  var url = "";

  MWebTextbook();

  factory MWebTextbook.fromJson(Map<String, dynamic> json) =>
      _$MWebTextbookFromJson(json);

  Map<String, dynamic> toJson() => _$MWebTextbookToJson(this);
}
