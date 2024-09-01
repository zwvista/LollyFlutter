// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mtextbook.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MTextbooks _$MTextbooksFromJson(Map<String, dynamic> json) => MTextbooks()
  ..lst = (json['records'] as List<dynamic>)
      .map((e) => MTextbook.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$MTextbooksToJson(MTextbooks instance) =>
    <String, dynamic>{
      'records': instance.lst,
    };

MTextbook _$MTextbookFromJson(Map<String, dynamic> json) => MTextbook()
  ..id = (json['ID'] as num).toInt()
  ..langid = (json['LANGID'] as num).toInt()
  ..textbookname = json['NAME'] as String
  ..units = json['UNITS'] as String
  ..parts = json['PARTS'] as String
  ..online = (json['ONLINE'] as num).toInt();

Map<String, dynamic> _$MTextbookToJson(MTextbook instance) => <String, dynamic>{
      'ID': instance.id,
      'LANGID': instance.langid,
      'NAME': instance.textbookname,
      'UNITS': instance.units,
      'PARTS': instance.parts,
      'ONLINE': instance.online,
    };
