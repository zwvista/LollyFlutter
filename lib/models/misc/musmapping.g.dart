// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'musmapping.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MUSMappings _$MUSMappingsFromJson(Map<String, dynamic> json) {
  return MUSMappings()
    ..lst = (json['records'] as List)
        ?.map((e) =>
            e == null ? null : MUSMapping.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$MUSMappingsToJson(MUSMappings instance) =>
    <String, dynamic>{
      'records': instance.lst,
    };

MUSMapping _$MUSMappingFromJson(Map<String, dynamic> json) {
  return MUSMapping()
    ..id = json['ID'] as int
    ..name = json['NAME'] as String
    ..kind = json['KIND'] as int
    ..entityid = json['ENTITYID'] as int
    ..valueid = json['VALUEID'] as int
    ..level = json['LEVEL'] as int;
}

Map<String, dynamic> _$MUSMappingToJson(MUSMapping instance) =>
    <String, dynamic>{
      'ID': instance.id,
      'NAME': instance.name,
      'KIND': instance.kind,
      'ENTITYID': instance.entityid,
      'VALUEID': instance.valueid,
      'LEVEL': instance.level,
    };
