// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'musersetting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MUserSettings _$MUserSettingsFromJson(Map<String, dynamic> json) =>
    MUserSettings()
      ..lst = (json['records'] as List<dynamic>)
          .map((e) => MUserSetting.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$MUserSettingsToJson(MUserSettings instance) =>
    <String, dynamic>{
      'records': instance.lst,
    };

MUserSetting _$MUserSettingFromJson(Map<String, dynamic> json) => MUserSetting()
  ..userid = json['USERID'] as String
  ..kind = (json['KIND'] as num).toInt()
  ..entityid = (json['ENTITYID'] as num).toInt()
  ..value1 = json['VALUE1'] as String?
  ..value2 = json['VALUE2'] as String?
  ..value3 = json['VALUE3'] as String?
  ..value4 = json['VALUE4'] as String?;

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
