import 'package:json_annotation/json_annotation.dart';
import 'package:lolly_flutter/models/misc/mtextbook.dart';

part 'munitword.g.dart';

@JsonSerializable()
class MUnitWords {
  @JsonKey(name: 'records')
  List<MUnitWord> lst = [];

  MUnitWords();
  factory MUnitWords.fromJson(Map<String, dynamic> json) =>
      _$MUnitWordsFromJson(json);
  Map<String, dynamic> toJson() => _$MUnitWordsToJson(this);
}

@JsonSerializable()
class MUnitWord {
  @JsonKey(name: 'ID', includeFromJson: false, includeToJson: true)
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
  @JsonKey(name: 'WORD')
  var word = "";
  @JsonKey(name: 'NOTE')
  var note = "";
  @JsonKey(name: 'WORDID')
  var wordid = 0;
  @JsonKey(name: 'FAMIID')
  var famiid = 0;
  @JsonKey(name: 'CORRECT')
  var correct = 0;
  @JsonKey(name: 'TOTAL')
  var total = 0;

  MTextbook? textbook;
  String get unitstr => textbook?.unitstr(unit) ?? "";
  String get partstr => textbook?.partstr(part) ?? "";
  String get accuracy =>
      total == 0 ? "N/A" : "${(correct / total * 1000).floor() / 10}%";

  MUnitWord();
  factory MUnitWord.fromJson(Map<String, dynamic> json) =>
      _$MUnitWordFromJson(json);
  Map<String, dynamic> toJson() => _$MUnitWordToJson(this);

  void copyFrom(MUnitWord x) {
    id = x.id;
    langid = x.langid;
    textbookid = x.textbookid;
    textbookname = x.textbookname;
    unit = x.unit;
    part = x.part;
    seqnum = x.seqnum;
    word = x.word;
    note = x.note;
    wordid = x.wordid;
    famiid = x.famiid;
    correct = x.correct;
    total = x.total;
    textbook = x.textbook;
  }
}
