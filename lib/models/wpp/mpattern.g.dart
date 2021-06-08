// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mpattern.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MPatterns _$MPatternsFromJson(Map<String, dynamic> json) {
  return MPatterns()
    ..lst = (json['records'] as List<dynamic>)
        .map((e) => MPattern.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$MPatternsToJson(MPatterns instance) => <String, dynamic>{
      'records': instance.lst,
    };

MPattern _$MPatternFromJson(Map<String, dynamic> json) {
  return MPattern()
    ..id = json['ID'] as int
    ..langid = json['LANGID'] as int
    ..pattern = json['PATTERN'] as String
    ..note = json['NOTE'] as String
    ..tags = json['TAGS'] as String
    ..idsMerge = json['IDS_MERGE'] as String
    ..patternsSplit = json['PATTERNS_SPLIT'] as String;
}

Map<String, dynamic> _$MPatternToJson(MPattern instance) => <String, dynamic>{
      'ID': instance.id,
      'LANGID': instance.langid,
      'PATTERN': instance.pattern,
      'NOTE': instance.note,
      'TAGS': instance.tags,
      'IDS_MERGE': instance.idsMerge,
      'PATTERNS_SPLIT': instance.patternsSplit,
    };
