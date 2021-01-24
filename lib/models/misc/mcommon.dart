import 'package:json_annotation/json_annotation.dart';

part 'mcommon.g.dart';

class GlobalConstants {
  static final userid = 1;
}

enum DictWebBrowserStatus { Ready, Navigating, Automating }

enum UnitPartToType { Unit, Part, To }

class MSelectItem {
  var value = 0;
  var label = "";

  MSelectItem(this.value, this.label);
}

@JsonSerializable()
class MCodes {
  @JsonKey(name: 'records')
  List<MCode> lst;

  MCodes();

  factory MCodes.fromJson(Map<String, dynamic> json) => _$MCodesFromJson(json);

  Map<String, dynamic> toJson() => _$MCodesToJson(this);
}

@JsonSerializable()
class MCode {
  @JsonKey(name: 'CODE')
  var code = 0;
  @JsonKey(name: 'NAME')
  var name = "";

  MCode();

  factory MCode.fromJson(Map<String, dynamic> json) => _$MCodeFromJson(json);

  Map<String, dynamic> toJson() => _$MCodeToJson(this);
}

@JsonSerializable()
class MSPResult {
  @JsonKey(name: 'NEW_ID')
  var newid = 0;
  @JsonKey(name: 'result')
  var result = "";

  MSPResult();

  factory MSPResult.fromJson(Map<String, dynamic> json) =>
      _$MSPResultFromJson(json);

  Map<String, dynamic> toJson() => _$MSPResultToJson(this);
}
