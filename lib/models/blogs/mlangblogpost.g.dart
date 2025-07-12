// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mlangblogpost.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MLangBlogPosts _$MLangBlogPostsFromJson(Map<String, dynamic> json) =>
    MLangBlogPosts()
      ..lst = (json['records'] as List<dynamic>)
          .map((e) => MLangBlogPost.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$MLangBlogPostsToJson(MLangBlogPosts instance) =>
    <String, dynamic>{
      'records': instance.lst,
    };

MLangBlogPost _$MLangBlogPostFromJson(Map<String, dynamic> json) =>
    MLangBlogPost()
      ..langid = (json['LANGID'] as num).toInt()
      ..title = json['TITLE'] as String
      ..url = json['URL'] as String;

Map<String, dynamic> _$MLangBlogPostToJson(MLangBlogPost instance) =>
    <String, dynamic>{
      'ID': instance.id,
      'LANGID': instance.langid,
      'TITLE': instance.title,
      'URL': instance.url,
    };
