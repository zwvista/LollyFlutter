// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monlinetextbook.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MOnlineTextbooks _$MOnlineTextbooksFromJson(Map<String, dynamic> json) =>
    MOnlineTextbooks()
      ..lst = (json['records'] as List<dynamic>)
          .map((e) => MOnlineTextbook.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$MOnlineTextbooksToJson(MOnlineTextbooks instance) =>
    <String, dynamic>{
      'records': instance.lst,
    };

MOnlineTextbook _$MOnlineTextbookFromJson(Map<String, dynamic> json) =>
    MOnlineTextbook()
      ..id = (json['ID'] as num).toInt()
      ..langid = (json['LANGID'] as num).toInt()
      ..textbookid = (json['TEXTBOOKID'] as num).toInt()
      ..textbookname = json['TEXTBOOKNAME'] as String
      ..unit = (json['UNIT'] as num).toInt()
      ..title = json['TITLE'] as String
      ..url = json['URL'] as String;

Map<String, dynamic> _$MOnlineTextbookToJson(MOnlineTextbook instance) =>
    <String, dynamic>{
      'LANGID': instance.langid,
      'TEXTBOOKID': instance.textbookid,
      'TEXTBOOKNAME': instance.textbookname,
      'UNIT': instance.unit,
      'TITLE': instance.title,
      'URL': instance.url,
    };
