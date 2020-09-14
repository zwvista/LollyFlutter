import 'package:json_annotation/json_annotation.dart';

part 'munitword.g.dart';

@JsonSerializable()
class MUnitWords {

  MUnitWords() {}

  factory MUnitWords.fromJson(Map<String, dynamic> json) => _$MUnitWordsFromJson(json);
  Map<String, dynamic> toJson() => _$MUnitWordsToJson(this);
}

@JsonSerializable()
class MUnitWord {

  MUnitWord() {}

  factory MUnitWord.fromJson(Map<String, dynamic> json) => _$MUnitWordFromJson(json);
  Map<String, dynamic> toJson() => _$MUnitWordToJson(this);
}
