// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mpatternwebpage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MPatternWebPages _$MPatternWebPagesFromJson(Map<String, dynamic> json) {
  return MPatternWebPages()
    ..lst = (json['records'] as List<dynamic>)
        .map((e) => MPatternWebPage.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$MPatternWebPagesToJson(MPatternWebPages instance) =>
    <String, dynamic>{
      'records': instance.lst,
    };

MPatternWebPage _$MPatternWebPageFromJson(Map<String, dynamic> json) {
  return MPatternWebPage()
    ..id = json['ID'] as int
    ..patternid = json['PATTERNID'] as int
    ..langid = json['LANGID'] as int
    ..pattern = json['PATTERN'] as String
    ..webpageid = json['WEBPAGEID'] as int
    ..seqnum = json['SEQNUM'] as int
    ..title = json['TITLE'] as String
    ..url = json['URL'] as String;
}

Map<String, dynamic> _$MPatternWebPageToJson(MPatternWebPage instance) =>
    <String, dynamic>{
      'ID': instance.id,
      'PATTERNID': instance.patternid,
      'LANGID': instance.langid,
      'PATTERN': instance.pattern,
      'WEBPAGEID': instance.webpageid,
      'SEQNUM': instance.seqnum,
      'TITLE': instance.title,
      'URL': instance.url,
    };
