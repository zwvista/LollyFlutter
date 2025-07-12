import 'package:json_annotation/json_annotation.dart';

import '../../main.dart';
import 'mcommon.dart';

part 'mtextbook.g.dart';

@JsonSerializable()
class MTextbooks {
  @JsonKey(name: 'records')
  List<MTextbook> lst = [];

  MTextbooks();

  factory MTextbooks.fromJson(Map<String, dynamic> json) =>
      _$MTextbooksFromJson(json);

  Map<String, dynamic> toJson() => _$MTextbooksToJson(this);
}

@JsonSerializable()
class MTextbook {
  @JsonKey(name: 'ID', includeFromJson: false, includeToJson: true)
  var id = 0;
  @JsonKey(name: 'LANGID')
  var langid = 0;
  @JsonKey(name: 'NAME')
  var textbookname = "";
  @JsonKey(name: 'UNITS')
  var units = "";
  @JsonKey(name: 'PARTS')
  var parts = "";
  @JsonKey(name: "ONLINE")
  var online = 0;

  @JsonKey(includeFromJson: false, includeToJson: false)
  List<MSelectItem> lstUnits = [];

  String unitstr(int unit) =>
      lstUnits.firstWhereOrNull((o) => o.value == unit)?.label ?? "";
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<MSelectItem> lstParts = [];

  String partstr(int part) =>
      lstParts.firstWhereOrNull((o) => o.value == part)?.label ?? "";

  MTextbook();

  factory MTextbook.fromJson(Map<String, dynamic> json) =>
      _$MTextbookFromJson(json);

  Map<String, dynamic> toJson() => _$MTextbookToJson(this);
}
