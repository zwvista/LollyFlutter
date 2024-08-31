// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mautocorrect.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MAutoCorrects _$MAutoCorrectsFromJson(Map<String, dynamic> json) =>
    MAutoCorrects()
      ..lst = (json['records'] as List<dynamic>)
          .map((e) => MAutoCorrect.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$MAutoCorrectsToJson(MAutoCorrects instance) =>
    <String, dynamic>{
      'records': instance.lst,
    };

MAutoCorrect _$MAutoCorrectFromJson(Map<String, dynamic> json) => MAutoCorrect()
  ..id = (json['ID'] as num).toInt()
  ..langid = (json['LANGID'] as num).toInt()
  ..seqnum = (json['SEQNUM'] as num).toInt()
  ..input = json['INPUT'] as String
  ..extended = json['EXTENDED'] as String
  ..basic = json['BASIC'] as String;

Map<String, dynamic> _$MAutoCorrectToJson(MAutoCorrect instance) =>
    <String, dynamic>{
      'ID': instance.id,
      'LANGID': instance.langid,
      'SEQNUM': instance.seqnum,
      'INPUT': instance.input,
      'EXTENDED': instance.extended,
      'BASIC': instance.basic,
    };
