// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mdictionary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MDictionaries _$MDictionariesFromJson(Map<String, dynamic> json) =>
    MDictionaries()
      ..lst = (json['records'] as List<dynamic>)
          .map((e) => MDictionary.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$MDictionariesToJson(MDictionaries instance) =>
    <String, dynamic>{
      'records': instance.lst,
    };

MDictionary _$MDictionaryFromJson(Map<String, dynamic> json) => MDictionary()
  ..id = (json['ID'] as num).toInt()
  ..dictid = (json['DICTID'] as num).toInt()
  ..langidfrom = (json['LANGIDFROM'] as num).toInt()
  ..langnamefrom = json['LANGNAMEFROM'] as String
  ..langidto = (json['LANGIDTO'] as num).toInt()
  ..langnameto = json['LANGNAMETO'] as String
  ..seqnum = (json['SEQNUM'] as num).toInt()
  ..dicttypecode = (json['DICTTYPECODE'] as num).toInt()
  ..dicttypename = json['DICTTYPENAME'] as String
  ..dictname = json['NAME'] as String
  ..url = json['URL'] as String
  ..chconv = json['CHCONV'] as String
  ..automation = json['AUTOMATION'] as String
  ..transform = json['TRANSFORM'] as String
  ..wait = (json['WAIT'] as num).toInt()
  ..template = json['TEMPLATE'] as String
  ..template2 = json['TEMPLATE2'] as String;

Map<String, dynamic> _$MDictionaryToJson(MDictionary instance) =>
    <String, dynamic>{
      'DICTID': instance.dictid,
      'LANGIDFROM': instance.langidfrom,
      'LANGNAMEFROM': instance.langnamefrom,
      'LANGIDTO': instance.langidto,
      'LANGNAMETO': instance.langnameto,
      'SEQNUM': instance.seqnum,
      'DICTTYPECODE': instance.dicttypecode,
      'DICTTYPENAME': instance.dicttypename,
      'NAME': instance.dictname,
      'URL': instance.url,
      'CHCONV': instance.chconv,
      'AUTOMATION': instance.automation,
      'TRANSFORM': instance.transform,
      'WAIT': instance.wait,
      'TEMPLATE': instance.template,
      'TEMPLATE2': instance.template2,
    };
