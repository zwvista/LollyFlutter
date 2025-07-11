// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mlangbloggp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MLangBlogGPs _$MLangBlogGPsFromJson(Map<String, dynamic> json) => MLangBlogGPs()
  ..lst = (json['records'] as List<dynamic>)
      .map((e) => MLangBlogGP.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$MLangBlogGPsToJson(MLangBlogGPs instance) =>
    <String, dynamic>{
      'records': instance.lst,
    };

MLangBlogGP _$MLangBlogGPFromJson(Map<String, dynamic> json) => MLangBlogGP()
  ..id = (json['ID'] as num).toInt()
  ..groupid = (json['GROUPID'] as num).toInt()
  ..postid = (json['POSTID'] as num).toInt()
  ..groupname = json['GROUPNAME'] as String
  ..title = json['TITLE'] as String
  ..url = json['URL'] as String;

Map<String, dynamic> _$MLangBlogGPToJson(MLangBlogGP instance) =>
    <String, dynamic>{
      'ID': instance.id,
      'GROUPID': instance.groupid,
      'POSTID': instance.postid,
      'GROUPNAME': instance.groupname,
      'TITLE': instance.title,
      'URL': instance.url,
    };
