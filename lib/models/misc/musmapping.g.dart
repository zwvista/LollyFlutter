// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'musmapping.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MUSMappings _$MUSMappingsFromJson(Map<String, dynamic> json) => MUSMappings()
  ..lst = (json['records'] as List<dynamic>)
      .map((e) => MUSMapping.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$MUSMappingsToJson(MUSMappings instance) =>
    <String, dynamic>{
      'records': instance.lst,
    };

MUSMapping _$MUSMappingFromJson(Map<String, dynamic> json) => MUSMapping()
  ..name = json['NAME'] as String
  ..kind = (json['KIND'] as num).toInt()
  ..entityid = (json['ENTITYID'] as num).toInt()
  ..valueid = (json['VALUEID'] as num).toInt()
  ..level = (json['LEVEL'] as num).toInt();

Map<String, dynamic> _$MUSMappingToJson(MUSMapping instance) =>
    <String, dynamic>{
      'ID': instance.id,
      'NAME': instance.name,
      'KIND': instance.kind,
      'ENTITYID': instance.entityid,
      'VALUEID': instance.valueid,
      'LEVEL': instance.level,
    };
