// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mlangblogpostcontent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MLangBlogPostContents _$MLangBlogPostContentsFromJson(
        Map<String, dynamic> json) =>
    MLangBlogPostContents()
      ..lst = (json['records'] as List<dynamic>)
          .map((e) => MLangBlogPostContent.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$MLangBlogPostContentsToJson(
        MLangBlogPostContents instance) =>
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
      'TITLE': instance.title,
      'CONTENT': instance.content,
    };
