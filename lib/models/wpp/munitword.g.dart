// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'munitword.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MUnitWords _$MUnitWordsFromJson(Map<String, dynamic> json) => MUnitWords()
  ..lst = (json['records'] as List<dynamic>)
      .map((e) => MUnitWord.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$MUnitWordsToJson(MUnitWords instance) =>
    <String, dynamic>{
      'records': instance.lst,
    };

MUnitWord _$MUnitWordFromJson(Map<String, dynamic> json) => MUnitWord()
  ..langid = (json['LANGID'] as num).toInt()
  ..textbookid = (json['TEXTBOOKID'] as num).toInt()
  ..textbookname = json['TEXTBOOKNAME'] as String
  ..unit = (json['UNIT'] as num).toInt()
  ..part = (json['PART'] as num).toInt()
  ..seqnum = (json['SEQNUM'] as num).toInt()
  ..word = json['WORD'] as String
  ..note = json['NOTE'] as String
  ..wordid = (json['WORDID'] as num).toInt()
  ..famiid = (json['FAMIID'] as num).toInt()
  ..correct = (json['CORRECT'] as num).toInt()
  ..total = (json['TOTAL'] as num).toInt()
  ..textbook = json['textbook'] == null
      ? null
      : MTextbook.fromJson(json['textbook'] as Map<String, dynamic>);

Map<String, dynamic> _$MUnitWordToJson(MUnitWord instance) => <String, dynamic>{
      'ID': instance.id,
      'LANGID': instance.langid,
      'TEXTBOOKID': instance.textbookid,
      'TEXTBOOKNAME': instance.textbookname,
      'UNIT': instance.unit,
      'PART': instance.part,
      'SEQNUM': instance.seqnum,
      'WORD': instance.word,
      'NOTE': instance.note,
      'WORDID': instance.wordid,
      'FAMIID': instance.famiid,
      'CORRECT': instance.correct,
      'TOTAL': instance.total,
      'textbook': instance.textbook,
    };
