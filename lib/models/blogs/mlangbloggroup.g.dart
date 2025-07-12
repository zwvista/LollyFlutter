// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mlangbloggroup.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MLangBlogGroups _$MLangBlogGroupsFromJson(Map<String, dynamic> json) =>
    MLangBlogGroups()
      ..lst = (json['records'] as List<dynamic>)
          .map((e) => MLangBlogGroup.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$MLangBlogGroupsToJson(MLangBlogGroups instance) =>
    <String, dynamic>{
      'records': instance.lst,
    };

MLangBlogGroup _$MLangBlogGroupFromJson(Map<String, dynamic> json) =>
    MLangBlogGroup()
      ..langid = (json['LANGID'] as num).toInt()
      ..groupname = json['NAME'] as String;

Map<String, dynamic> _$MLangBlogGroupToJson(MLangBlogGroup instance) =>
    <String, dynamic>{
      'ID': instance.id,
      'LANGID': instance.langid,
      'NAME': instance.groupname,
    };
