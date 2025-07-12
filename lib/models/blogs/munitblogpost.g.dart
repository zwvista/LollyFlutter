// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'munitblogpost.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MUnitBlogPosts _$MUnitBlogPostsFromJson(Map<String, dynamic> json) =>
    MUnitBlogPosts()
      ..lst = (json['records'] as List<dynamic>)
          .map((e) => MUnitBlogPost.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$MUnitBlogPostsToJson(MUnitBlogPosts instance) =>
    <String, dynamic>{
      'records': instance.lst,
    };

MUnitBlogPost _$MUnitBlogPostFromJson(Map<String, dynamic> json) =>
    MUnitBlogPost()
      ..textbookid = (json['TEXTBOOKID'] as num).toInt()
      ..unit = (json['UNIT'] as num).toInt()
      ..content = json['CONTENT'] as String;

Map<String, dynamic> _$MUnitBlogPostToJson(MUnitBlogPost instance) =>
    <String, dynamic>{
      'ID': instance.id,
      'TEXTBOOKID': instance.textbookid,
      'UNIT': instance.unit,
      'CONTENT': instance.content,
    };
