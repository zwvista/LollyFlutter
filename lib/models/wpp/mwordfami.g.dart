// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mwordfami.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MWordsFami _$MWordsFamiFromJson(Map<String, dynamic> json) => MWordsFami()
  ..lst = (json['records'] as List<dynamic>)
      .map((e) => MWordFami.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$MWordsFamiToJson(MWordsFami instance) =>
    <String, dynamic>{
      'records': instance.lst,
    };

MWordFami _$MWordFamiFromJson(Map<String, dynamic> json) => MWordFami()
  ..id = (json['ID'] as num).toInt()
  ..userid = json['USERID'] as String
  ..wordid = (json['WORDID'] as num).toInt()
  ..correct = (json['CORRECT'] as num).toInt()
  ..total = (json['TOTAL'] as num).toInt();

Map<String, dynamic> _$MWordFamiToJson(MWordFami instance) => <String, dynamic>{
      'USERID': instance.userid,
      'WORDID': instance.wordid,
      'CORRECT': instance.correct,
      'TOTAL': instance.total,
    };
