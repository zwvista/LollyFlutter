import 'package:json_annotation/json_annotation.dart';

part 'mcommon.g.dart';

@JsonSerializable()
class MSPResult {
    @JsonKey(name: 'NEW_ID')
    String newid;
    @JsonKey(name: 'result')
    var result = "";

    MSPResult() {}
    factory MSPResult.fromJson(Map<String, dynamic> json) => _$MSPResultFromJson(json);
    Map<String, dynamic> toJson() => _$MSPResultToJson(this);
}
