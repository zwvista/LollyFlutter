// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mlangword.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MLangWords _$MLangWordsFromJson(Map<String, dynamic> json) => MLangWords()
  ..lst = (json['records'] as List<dynamic>)
      .map((e) => MLangWord.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$MLangWordsToJson(MLangWords instance) =>
    <String, dynamic>{
      'records': instance.lst,
    };

MLangWord _$MLangWordFromJson(Map<String, dynamic> json) => MLangWord()
  ..id = (json['ID'] as num).toInt()
  ..langid = (json['LANGID'] as num).toInt()
  ..word = json['WORD'] as String
  ..note = json['NOTE'] as String
  ..famiid = (json['FAMIID'] as num).toInt()
  ..correct = (json['CORRECT'] as num).toInt()
  ..total = (json['TOTAL'] as num).toInt();

Map<String, dynamic> _$MLangWordToJson(MLangWord instance) => <String, dynamic>{
      'LANGID': instance.langid,
      'WORD': instance.word,
      'NOTE': instance.note,
      'FAMIID': instance.famiid,
      'CORRECT': instance.correct,
      'TOTAL': instance.total,
    };
