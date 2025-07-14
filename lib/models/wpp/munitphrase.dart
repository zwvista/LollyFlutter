import 'package:json_annotation/json_annotation.dart';
import 'package:lolly_flutter/models/misc/mtextbook.dart';

part 'munitphrase.g.dart';

@JsonSerializable()
class MUnitPhrases {
  @JsonKey(name: 'records')
  List<MUnitPhrase> lst = [];

  MUnitPhrases();
  factory MUnitPhrases.fromJson(Map<String, dynamic> json) =>
      _$MUnitPhrasesFromJson(json);
  Map<String, dynamic> toJson() => _$MUnitPhrasesToJson(this);
}

@JsonSerializable()
class MUnitPhrase {
  @JsonKey(name: 'ID', includeFromJson: true, includeToJson: false)
  var id = 0;
  @JsonKey(name: 'LANGID')
  var langid = 0;
  @JsonKey(name: 'TEXTBOOKID')
  var textbookid = 0;
  @JsonKey(name: 'TEXTBOOKNAME')
  var textbookname = "";
  @JsonKey(name: 'UNIT')
  var unit = 0;
  @JsonKey(name: 'PART')
  var part = 0;
  @JsonKey(name: 'SEQNUM')
  var seqnum = 0;
  @JsonKey(name: 'PHRASEID')
  var phraseid = 0;
  @JsonKey(name: 'PHRASE')
  var phrase = "";
  @JsonKey(name: 'TRANSLATION')
  var translation = "";

  MTextbook? textbook;
  String get unitstr => textbook?.unitstr(unit) ?? "";
  String get partstr => textbook?.partstr(part) ?? "";

  MUnitPhrase();
  factory MUnitPhrase.fromJson(Map<String, dynamic> json) =>
      _$MUnitPhraseFromJson(json);
  Map<String, dynamic> toJson() => _$MUnitPhraseToJson(this);

  void copyFrom(MUnitPhrase x) {
    id = x.id;
    langid = x.langid;
    textbookid = x.textbookid;
    textbookname = x.textbookname;
    unit = x.unit;
    part = x.part;
    seqnum = x.seqnum;
    phrase = x.phrase;
    translation = x.translation;
    phraseid = x.phraseid;
    textbook = x.textbook;
  }
}
