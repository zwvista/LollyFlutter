// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'munitphrase.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MUnitPhrases _$MUnitPhrasesFromJson(Map<String, dynamic> json) {
  return MUnitPhrases()
    ..lst = (json['records'] as List<dynamic>)
        .map((e) => MUnitPhrase.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$MUnitPhrasesToJson(MUnitPhrases instance) =>
    <String, dynamic>{
      'records': instance.lst,
    };

MUnitPhrase _$MUnitPhraseFromJson(Map<String, dynamic> json) {
  return MUnitPhrase()
    ..id = json['ID'] as int
    ..langid = json['LANGID'] as int
    ..textbookid = json['TEXTBOOKID'] as int
    ..textbookname = json['TEXTBOOKNAME'] as String
    ..unit = json['UNIT'] as int
    ..part = json['PART'] as int
    ..seqnum = json['SEQNUM'] as int
    ..phraseid = json['PHRASEID'] as int
    ..phrase = json['PHRASE'] as String
    ..translation = json['TRANSLATION'] as String
    ..textbook = json['textbook'] == null
        ? null
        : MTextbook.fromJson(json['textbook'] as Map<String, dynamic>);
}

Map<String, dynamic> _$MUnitPhraseToJson(MUnitPhrase instance) =>
    <String, dynamic>{
      'ID': instance.id,
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
