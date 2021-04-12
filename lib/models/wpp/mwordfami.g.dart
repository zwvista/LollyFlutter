// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mwordfami.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MWordsFami _$MWordsFamiFromJson(Map<String, dynamic> json) {
  return MWordsFami()
    ..lst = (json['records'] as List)
        ?.map((e) =>
            e == null ? null : MWordFami.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$MWordsFamiToJson(MWordsFami instance) =>
    <String, dynamic>{
      'records': instance.lst,
    };

MWordFami _$MWordFamiFromJson(Map<String, dynamic> json) {
  return MWordFami()
    ..id = json['ID'] as int
    ..userid = json['USERID'] as String
    ..wordid = json['WORDID'] as int
    ..correct = json['CORRECT'] as int
    ..total = json['TOTAL'] as int;
}

Map<String, dynamic> _$MWordFamiToJson(MWordFami instance) => <String, dynamic>{
      'ID': instance.id,
      'USERID': instance.userid,
      'WORDID': instance.wordid,
      'CORRECT': instance.correct,
      'TOTAL': instance.total,
    };
