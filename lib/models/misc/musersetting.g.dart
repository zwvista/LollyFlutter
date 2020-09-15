// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'musersetting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MUserSettings _$MUserSettingsFromJson(Map<String, dynamic> json) {
  return MUserSettings()
    ..lst = (json['records'] as List)
        ?.map((e) =>
            e == null ? null : MUserSetting.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$MUserSettingsToJson(MUserSettings instance) =>
    <String, dynamic>{
      'records': instance.lst,
    };

MUserSetting _$MUserSettingFromJson(Map<String, dynamic> json) {
  return MUserSetting()
    ..id = json['ID'] as int
    ..userid = json['USERID'] as int
    ..kind = json['KIND'] as int
    ..entityid = json['ENTITYID'] as int
    ..value1 = json['VALUE1'] as String
    ..value2 = json['VALUE2'] as String
    ..value3 = json['VALUE3'] as String
    ..value4 = json['VALUE4'] as String;
}

Map<String, dynamic> _$MUserSettingToJson(MUserSetting instance) =>
    <String, dynamic>{
      'ID': instance.id,
      'USERID': instance.userid,
      'KIND': instance.kind,
      'ENTITYID': instance.entityid,
      'VALUE1': instance.value1,
      'VALUE2': instance.value2,
      'VALUE3': instance.value3,
      'VALUE4': instance.value4,
    };
