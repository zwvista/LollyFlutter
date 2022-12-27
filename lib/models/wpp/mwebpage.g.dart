// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mwebpage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MWebPages _$MWebPagesFromJson(Map<String, dynamic> json) => MWebPages()
  ..lst = (json['records'] as List<dynamic>)
      .map((e) => MWebPage.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$MWebPagesToJson(MWebPages instance) => <String, dynamic>{
      'records': instance.lst,
    };

MWebPage _$MWebPageFromJson(Map<String, dynamic> json) => MWebPage()
  ..id = json['ID'] as int
  ..title = json['TITLE'] as String
  ..url = json['URL'] as String;

Map<String, dynamic> _$MWebPageToJson(MWebPage instance) => <String, dynamic>{
      'ID': instance.id,
      'TITLE': instance.title,
      'URL': instance.url,
    };
