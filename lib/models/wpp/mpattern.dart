import 'package:json_annotation/json_annotation.dart';

part 'mpattern.g.dart';

@JsonSerializable()
class MPatterns {
  @JsonKey(name: 'records')
  List<MPattern> lst = [];

  MPatterns();
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
  @JsonKey(name: 'PATTERN')
  var pattern = "";
  @JsonKey(name: 'NOTE')
  var note = "";
  @JsonKey(name: 'TAGS')
  var tags = "";
  @JsonKey(name: 'IDS_MERGE')
  String? idsMerge = "";
  @JsonKey(name: 'PATTERNS_SPLIT')
  String? patternsSplit = "";

  MPattern();
  factory MPattern.fromJson(Map<String, dynamic> json) =>
      _$MPatternFromJson(json);
  Map<String, dynamic> toJson() => _$MPatternToJson(this);
}
