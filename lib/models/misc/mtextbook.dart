import 'package:json_annotation/json_annotation.dart';

import 'mcommon.dart';

part 'mtextbook.g.dart';

@JsonSerializable()
class MTextbooks {
  @JsonKey(name: 'records')
  List<MTextbook> lst;

  MTextbooks() {}

  factory MTextbooks.fromJson(Map<String, dynamic> json) =>
      _$MTextbooksFromJson(json);

  Map<String, dynamic> toJson() => _$MTextbooksToJson(this);
}

@JsonSerializable()
class MTextbook {
  @JsonKey(name: 'ID')
  var id = 0;
  @JsonKey(name: 'LANGID')
  var langid = 0;
  @JsonKey(name: 'NAME')
  String textbookname;
  @JsonKey(name: 'UNITS')
  var units = "";
  @JsonKey(name: 'PARTS')
  var parts = "";

  @JsonKey(ignore: true)
  List<MSelectItem> lstUnits;

  String unitstr(int unit) =>
      lstUnits.firstWhere((o) => o.value == unit, orElse: () => null)?.label;
  @JsonKey(ignore: true)
  List<MSelectItem> lstParts;

  String partstr(int part) =>
      lstParts.firstWhere((o) => o.value == part, orElse: () => null)?.label;

  MTextbook() {}

  factory MTextbook.fromJson(Map<String, dynamic> json) =>
      _$MTextbookFromJson(json);

  Map<String, dynamic> toJson() => _$MTextbookToJson(this);
}
