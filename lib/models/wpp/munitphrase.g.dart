// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'munitphrase.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MUnitPhrases _$MUnitPhrasesFromJson(Map<String, dynamic> json) => MUnitPhrases()
  ..lst = (json['records'] as List<dynamic>)
      .map((e) => MUnitPhrase.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$MUnitPhrasesToJson(MUnitPhrases instance) =>
    <String, dynamic>{
      'records': instance.lst,
    };

MUnitPhrase _$MUnitPhraseFromJson(Map<String, dynamic> json) => MUnitPhrase()
  ..id = (json['ID'] as num).toInt()
  ..langid = (json['LANGID'] as num).toInt()
  ..textbookid = (json['TEXTBOOKID'] as num).toInt()
  ..textbookname = json['TEXTBOOKNAME'] as String
  ..unit = (json['UNIT'] as num).toInt()
  ..part = (json['PART'] as num).toInt()
  ..seqnum = (json['SEQNUM'] as num).toInt()
  ..phraseid = (json['PHRASEID'] as num).toInt()
  ..phrase = json['PHRASE'] as String
  ..translation = json['TRANSLATION'] as String
  ..textbook = json['textbook'] == null
      ? null
      : MTextbook.fromJson(json['textbook'] as Map<String, dynamic>);

Map<String, dynamic> _$MUnitPhraseToJson(MUnitPhrase instance) =>
    <String, dynamic>{
      'LANGID': instance.langid,
      'TEXTBOOKID': instance.textbookid,
      'TEXTBOOKNAME': instance.textbookname,
      'UNIT': instance.unit,
      'PART': instance.part,
      'SEQNUM': instance.seqnum,
      'PHRASEID': instance.phraseid,
      'PHRASE': instance.phrase,
      'TRANSLATION': instance.translation,
      'textbook': instance.textbook,
    };
