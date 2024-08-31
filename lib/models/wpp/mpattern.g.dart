// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mpattern.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MPatterns _$MPatternsFromJson(Map<String, dynamic> json) => MPatterns()
  ..lst = (json['records'] as List<dynamic>)
      .map((e) => MPattern.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$MPatternsToJson(MPatterns instance) => <String, dynamic>{
      'records': instance.lst,
    };

MPattern _$MPatternFromJson(Map<String, dynamic> json) => MPattern()
  ..id = (json['ID'] as num).toInt()
  ..langid = (json['LANGID'] as num).toInt()
  ..pattern = json['PATTERN'] as String
  ..tags = json['TAGS'] as String
  ..title = json['TITLE'] as String
  ..url = json['URL'] as String;

Map<String, dynamic> _$MPatternToJson(MPattern instance) => <String, dynamic>{
      'ID': instance.id,
      'LANGID': instance.langid,
      'PATTERN': instance.pattern,
      'TAGS': instance.tags,
      'TITLE': instance.title,
      'URL': instance.url,
    };
