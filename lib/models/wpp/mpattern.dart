import 'package:json_annotation/json_annotation.dart';

part 'mpattern.g.dart';

@JsonSerializable()
class MPatterns {
  @JsonKey(name: 'records')
  List<MPattern> lst;

  MPatterns() {}
  factory MPatterns.fromJson(Map<String, dynamic> json) =>
      _$MPatternsFromJson(json);
  Map<String, dynamic> toJson() => _$MPatternsToJson(this);
}

@JsonSerializable()
class MPattern {
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

  MPattern() {}
  factory MPattern.fromJson(Map<String, dynamic> json) =>
      _$MPatternFromJson(json);
  Map<String, dynamic> toJson() => _$MPatternToJson(this);
}
