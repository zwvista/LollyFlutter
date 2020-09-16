// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mtextbook.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MTextbooks _$MTextbooksFromJson(Map<String, dynamic> json) {
  return MTextbooks()
    ..lst = (json['records'] as List)
        ?.map((e) =>
            e == null ? null : MTextbook.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$MTextbooksToJson(MTextbooks instance) =>
    <String, dynamic>{
      'records': instance.lst,
    };

MTextbook _$MTextbookFromJson(Map<String, dynamic> json) {
  return MTextbook()
    ..id = json['ID'] as int
    ..langid = json['LANGID'] as int
    ..textbookname = json['NAME'] as String
    ..units = json['UNITS'] as String
    ..parts = json['PARTS'] as String
    ..lstUnits = json['lstUnits'] as List
    ..lstParts = json['lstParts'] as List;
}

Map<String, dynamic> _$MTextbookToJson(MTextbook instance) => <String, dynamic>{
      'ID': instance.id,
      'LANGID': instance.langid,
      'NAME': instance.textbookname,
      'UNITS': instance.units,
      'PARTS': instance.parts,
      'lstUnits': instance.lstUnits,
      'lstParts': instance.lstParts,
    };
