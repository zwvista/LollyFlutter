import 'package:json_annotation/json_annotation.dart';

part 'mlangword.g.dart';

@JsonSerializable()
class MLangWords {
  @JsonKey(name: 'records')
  List<MLangWord> lst = [];

  MLangWords();
  factory MLangWords.fromJson(Map<String, dynamic> json) =>
      _$MLangWordsFromJson(json);
  Map<String, dynamic> toJson() => _$MLangWordsToJson(this);
}

@JsonSerializable()
class MLangWord {
  @JsonKey(name: 'ID', includeFromJson: true, includeToJson: false)
  var id = 0;
  @JsonKey(name: 'LANGID')
  var langid = 0;
  @JsonKey(name: 'WORD')
  var word = "";
  @JsonKey(name: 'NOTE')
  var note = "";
  @JsonKey(name: 'FAMIID')
  var famiid = 0;
  @JsonKey(name: 'CORRECT')
  var correct = 0;
  @JsonKey(name: 'TOTAL')
  var total = 0;

  String get accuracy =>
      total == 0 ? "N/A" : "${(correct / total * 1000).floor() / 10}%";

  MLangWord();
  factory MLangWord.fromJson(Map<String, dynamic> json) =>
      _$MLangWordFromJson(json);
  Map<String, dynamic> toJson() => _$MLangWordToJson(this);
}
