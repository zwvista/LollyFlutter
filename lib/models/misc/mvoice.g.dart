// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mvoice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MVoices _$MVoicesFromJson(Map<String, dynamic> json) => MVoices()
  ..lst = (json['records'] as List<dynamic>)
      .map((e) => MVoice.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$MVoicesToJson(MVoices instance) => <String, dynamic>{
      'records': instance.lst,
    };

MVoice _$MVoiceFromJson(Map<String, dynamic> json) => MVoice()
  ..langid = (json['LANGID'] as num).toInt()
  ..voicetypeid = (json['VOICETYPEID'] as num).toInt()
  ..voicelang = json['VOICELANG'] as String
  ..voicename = json['VOICENAME'] as String;

Map<String, dynamic> _$MVoiceToJson(MVoice instance) => <String, dynamic>{
      'ID': instance.id,
      'LANGID': instance.langid,
      'VOICETYPEID': instance.voicetypeid,
      'VOICELANG': instance.voicelang,
      'VOICENAME': instance.voicename,
    };
