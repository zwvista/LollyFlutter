// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mcommon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MCodes _$MCodesFromJson(Map<String, dynamic> json) {
  return MCodes()
    ..lst = (json['records'] as List<dynamic>)
        .map((e) => MCode.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$MCodesToJson(MCodes instance) => <String, dynamic>{
      'records': instance.lst,
    };

MCode _$MCodeFromJson(Map<String, dynamic> json) {
  return MCode()
    ..code = json['CODE'] as int
    ..name = json['NAME'] as String;
}

Map<String, dynamic> _$MCodeToJson(MCode instance) => <String, dynamic>{
      'CODE': instance.code,
      'NAME': instance.name,
    };

MSPResult _$MSPResultFromJson(Map<String, dynamic> json) {
  return MSPResult()
    ..newid = json['NEW_ID'] as int
    ..result = json['result'] as String;
}

Map<String, dynamic> _$MSPResultToJson(MSPResult instance) => <String, dynamic>{
      'NEW_ID': instance.newid,
      'result': instance.result,
    };
