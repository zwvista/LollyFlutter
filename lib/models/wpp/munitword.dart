import 'package:json_annotation/json_annotation.dart';

part 'munitword.g.dart';

@JsonSerializable()
class MUnitWords {
  @JsonKey(name: 'records')
  List<MUnitWord> lst;

  MUnitWords() {}
  factory MUnitWords.fromJson(Map<String, dynamic> json) => _$MUnitWordsFromJson(json);
  Map<String, dynamic> toJson() => _$MUnitWordsToJson(this);
}

@JsonSerializable()
class MUnitWord {
  @JsonKey(name: 'ID')
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
  String note;
  @JsonKey(name: 'WORDID')
  var wordid = 0;
  @JsonKey(name: 'FAMIID')
  var famiid = 0;
  @JsonKey(name: 'CORRECT')
  var correct = 0;
  @JsonKey(name: 'TOTAL')
  var total = 0;

  MUnitWord() {}
  factory MUnitWord.fromJson(Map<String, dynamic> json) => _$MUnitWordFromJson(json);
  Map<String, dynamic> toJson() => _$MUnitWordToJson(this);
}
