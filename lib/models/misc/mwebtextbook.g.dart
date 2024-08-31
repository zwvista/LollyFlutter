// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mwebtextbook.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MWebTextbooks _$MWebTextbooksFromJson(Map<String, dynamic> json) =>
    MWebTextbooks()
      ..lst = (json['records'] as List<dynamic>)
          .map((e) => MWebTextbook.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$MWebTextbooksToJson(MWebTextbooks instance) =>
    <String, dynamic>{
      'records': instance.lst,
    };

MWebTextbook _$MWebTextbookFromJson(Map<String, dynamic> json) => MWebTextbook()
  ..id = (json['ID'] as num).toInt()
  ..langid = (json['LANGID'] as num).toInt()
  ..textbookid = (json['TEXTBOOKID'] as num).toInt()
  ..textbookname = json['TEXTBOOKNAME'] as String
  ..unit = (json['UNIT'] as num).toInt()
  ..title = json['TITLE'] as String
  ..url = json['URL'] as String;

Map<String, dynamic> _$MWebTextbookToJson(MWebTextbook instance) =>
    <String, dynamic>{
      'ID': instance.id,
      'LANGID': instance.langid,
      'TEXTBOOKID': instance.textbookid,
      'TEXTBOOKNAME': instance.textbookname,
      'UNIT': instance.unit,
      'TITLE': instance.title,
      'URL': instance.url,
    };
