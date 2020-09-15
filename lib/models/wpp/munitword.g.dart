// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'munitword.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MUnitWords _$MUnitWordsFromJson(Map<String, dynamic> json) {
  return MUnitWords()
    ..lst = (json['records'] as List)
        ?.map((e) =>
            e == null ? null : MUnitWord.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$MUnitWordsToJson(MUnitWords instance) =>
    <String, dynamic>{
      'records': instance.lst,
    };

MUnitWord _$MUnitWordFromJson(Map<String, dynamic> json) {
  return MUnitWord()
    ..id = json['ID'] as int
    ..langid = json['LANGID'] as int
    ..textbookid = json['TEXTBOOKID'] as int
    ..textbookname = json['TEXTBOOKNAME'] as String
    ..unit = json['UNIT'] as int
    ..part = json['PART'] as int
    ..seqnum = json['SEQNUM'] as int
    ..word = json['WORD'] as String
    ..note = json['NOTE'] as String
    ..wordid = json['WORDID'] as int
    ..famiid = json['FAMIID'] as int
    ..correct = json['CORRECT'] as int
    ..total = json['TOTAL'] as int;
}

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
    };
