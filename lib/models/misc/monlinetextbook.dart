import 'package:json_annotation/json_annotation.dart';

part 'monlinetextbook.g.dart';

@JsonSerializable()
class MOnlineTextbooks {
  @JsonKey(name: 'records')
  List<MOnlineTextbook> lst = [];

  MOnlineTextbooks();

  factory MOnlineTextbooks.fromJson(Map<String, dynamic> json) =>
      _$MOnlineTextbooksFromJson(json);

  Map<String, dynamic> toJson() => _$MOnlineTextbooksToJson(this);
}

@JsonSerializable()
class MOnlineTextbook {
  @JsonKey(name: 'ID', includeFromJson: false, includeToJson: true)
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

  MOnlineTextbook();

  factory MOnlineTextbook.fromJson(Map<String, dynamic> json) =>
      _$MOnlineTextbookFromJson(json);

  Map<String, dynamic> toJson() => _$MOnlineTextbookToJson(this);
}
