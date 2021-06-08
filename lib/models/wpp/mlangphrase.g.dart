// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mlangphrase.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MLangPhrases _$MLangPhrasesFromJson(Map<String, dynamic> json) {
  return MLangPhrases()
    ..lst = (json['records'] as List<dynamic>)
        .map((e) => MLangPhrase.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$MLangPhrasesToJson(MLangPhrases instance) =>
    <String, dynamic>{
      'records': instance.lst,
    };

MLangPhrase _$MLangPhraseFromJson(Map<String, dynamic> json) {
  return MLangPhrase()
    ..id = json['ID'] as int
    ..langid = json['LANGID'] as int
    ..phrase = json['PHRASE'] as String
    ..translation = json['TRANSLATION'] as String;
}

Map<String, dynamic> _$MLangPhraseToJson(MLangPhrase instance) =>
    <String, dynamic>{
      'ID': instance.id,
      'LANGID': instance.langid,
      'PHRASE': instance.phrase,
      'TRANSLATION': instance.translation,
    };
