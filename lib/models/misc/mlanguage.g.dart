// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mlanguage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MLanguages _$MLanguagesFromJson(Map<String, dynamic> json) {
  return MLanguages()
    ..lst = (json['records'] as List<dynamic>)
        .map((e) => MLanguage.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$MLanguagesToJson(MLanguages instance) =>
    <String, dynamic>{
      'records': instance.lst,
    };

MLanguage _$MLanguageFromJson(Map<String, dynamic> json) {
  return MLanguage()
    ..id = json['ID'] as int
    ..langname = json['NAME'] as String;
}

Map<String, dynamic> _$MLanguageToJson(MLanguage instance) => <String, dynamic>{
      'ID': instance.id,
      'NAME': instance.langname,
    };
