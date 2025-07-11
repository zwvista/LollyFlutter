// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mlangblogcontent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MLangBlogsContent _$MLangBlogsContentFromJson(Map<String, dynamic> json) =>
    MLangBlogsContent()
      ..lst = (json['records'] as List<dynamic>)
          .map((e) => MLangBlogPostContent.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$MLangBlogsContentToJson(MLangBlogsContent instance) =>
    <String, dynamic>{
      'records': instance.lst,
    };

MLangBlogPostContent _$MLangBlogPostContentFromJson(
        Map<String, dynamic> json) =>
    MLangBlogPostContent()
      ..id = (json['ID'] as num).toInt()
      ..title = json['TITLE'] as String
      ..content = json['CONTENT'] as String;

Map<String, dynamic> _$MLangBlogPostContentToJson(
        MLangBlogPostContent instance) =>
    <String, dynamic>{
      'ID': instance.id,
      'TITLE': instance.title,
      'CONTENT': instance.content,
    };
