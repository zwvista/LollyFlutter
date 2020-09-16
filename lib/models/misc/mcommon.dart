import 'package:json_annotation/json_annotation.dart';

part 'mcommon.g.dart';

class MSelectItem {
  var value = 0;
  var label = "";

  MSelectItem(this.value, this.label);
}

@JsonSerializable()
class MSPResult {
  @JsonKey(name: 'NEW_ID')
  var newid = 0;
  @JsonKey(name: 'result')
  var result = "";

  MSPResult() {}

  factory MSPResult.fromJson(Map<String, dynamic> json) =>
      _$MSPResultFromJson(json);

  Map<String, dynamic> toJson() => _$MSPResultToJson(this);
}
