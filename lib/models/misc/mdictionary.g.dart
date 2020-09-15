// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mdictionary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MDictsReference _$MDictsReferenceFromJson(Map<String, dynamic> json) {
  return MDictsReference()
    ..lst = (json['records'] as List)
        ?.map((e) =>
            e == null ? null : MDictionary.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$MDictsReferenceToJson(MDictsReference instance) =>
    <String, dynamic>{
      'records': instance.lst,
    };

MDictsNote _$MDictsNoteFromJson(Map<String, dynamic> json) {
  return MDictsNote()
    ..lst = (json['records'] as List)
        ?.map((e) =>
            e == null ? null : MDictionary.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$MDictsNoteToJson(MDictsNote instance) =>
    <String, dynamic>{
      'records': instance.lst,
    };

MDictsTranslation _$MDictsTranslationFromJson(Map<String, dynamic> json) {
  return MDictsTranslation()
    ..lst = (json['records'] as List)
        ?.map((e) =>
            e == null ? null : MDictionary.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$MDictsTranslationToJson(MDictsTranslation instance) =>
    <String, dynamic>{
      'records': instance.lst,
    };

MDictionary _$MDictionaryFromJson(Map<String, dynamic> json) {
  return MDictionary()
    ..id = json['ID'] as int
    ..dictid = json['DICTID'] as int
    ..langidfrom = json['LANGIDFROM'] as int
    ..langnamefrom = json['LANGNAMEFROM'] as String
    ..langidto = json['LANGIDTO'] as int
    ..langnameto = json['LANGNAMETO'] as String
    ..seqnum = json['SEQNUM'] as int
    ..dicttypeid = json['DICTTYPEID'] as int
    ..dicttypename = json['DICTTYPENAME'] as String
    ..dictname = json['DICTNAME'] as String
    ..url = json['URL'] as String
    ..chconv = json['CHCONV'] as String
    ..automation = json['AUTOMATION'] as String
    ..transform = json['TRANSFORM'] as String
    ..wait = json['WAIT'] as int
    ..template = json['TEMPLATE'] as String
    ..template2 = json['TEMPLATE2'] as String;
}

Map<String, dynamic> _$MDictionaryToJson(MDictionary instance) =>
    <String, dynamic>{
      'ID': instance.id,
      'DICTID': instance.dictid,
      'LANGIDFROM': instance.langidfrom,
      'LANGNAMEFROM': instance.langnamefrom,
      'LANGIDTO': instance.langidto,
      'LANGNAMETO': instance.langnameto,
      'SEQNUM': instance.seqnum,
      'DICTTYPEID': instance.dicttypeid,
      'DICTTYPENAME': instance.dicttypename,
      'DICTNAME': instance.dictname,
      'URL': instance.url,
      'CHCONV': instance.chconv,
      'AUTOMATION': instance.automation,
      'TRANSFORM': instance.transform,
      'WAIT': instance.wait,
      'TEMPLATE': instance.template,
      'TEMPLATE2': instance.template2,
    };
