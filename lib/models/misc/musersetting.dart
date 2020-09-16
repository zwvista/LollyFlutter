import 'package:json_annotation/json_annotation.dart';

part 'musersetting.g.dart';

@JsonSerializable()
class MUserSettings {
  @JsonKey(name: 'records')
  List<MUserSetting> lst;

  MUserSettings() {}

  factory MUserSettings.fromJson(Map<String, dynamic> json) =>
      _$MUserSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$MUserSettingsToJson(this);
}

@JsonSerializable()
class MUserSetting {
  @JsonKey(name: 'ID')
  var id = 0;
  @JsonKey(name: 'USERID')
  var userid = 0;
  @JsonKey(name: 'KIND')
  var kind = 0;
  @JsonKey(name: 'ENTITYID')
  var entityid = 0;
  @JsonKey(name: 'VALUE1')
  String value1;
  @JsonKey(name: 'VALUE2')
  String value2;
  @JsonKey(name: 'VALUE3')
  String value3;
  @JsonKey(name: 'VALUE4')
  String value4;

  MUserSetting() {}

  factory MUserSetting.fromJson(Map<String, dynamic> json) =>
      _$MUserSettingFromJson(json);

  Map<String, dynamic> toJson() => _$MUserSettingToJson(this);
}

class MUserSettingInfo {
  final int usersettingid;
  final int valueid;

  MUserSettingInfo(this.usersettingid, this.valueid);
}
