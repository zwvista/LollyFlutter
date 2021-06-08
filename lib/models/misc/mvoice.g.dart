// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mvoice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MVoices _$MVoicesFromJson(Map<String, dynamic> json) {
  return MVoices()
    ..lst = (json['records'] as List<dynamic>)
        .map((e) => MVoice.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$MVoicesToJson(MVoices instance) => <String, dynamic>{
      'records': instance.lst,
    };

MVoice _$MVoiceFromJson(Map<String, dynamic> json) {
  return MVoice()
    ..id = json['ID'] as int
    ..langid = json['LANGID'] as int
    ..voicetypeid = json['VOICETYPEID'] as int
    ..voicelang = json['VOICELANG'] as String
    ..voicename = json['VOICENAME'] as String;
}

Map<String, dynamic> _$MVoiceToJson(MVoice instance) => <String, dynamic>{
      'ID': instance.id,
      'LANGID': instance.langid,
      'VOICETYPEID': instance.voicetypeid,
      'VOICELANG': instance.voicelang,
      'VOICENAME': instance.voicename,
    };
