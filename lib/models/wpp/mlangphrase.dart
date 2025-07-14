import 'package:json_annotation/json_annotation.dart';

part 'mlangphrase.g.dart';

@JsonSerializable()
class MLangPhrases {
  @JsonKey(name: 'records')
  List<MLangPhrase> lst = [];

  MLangPhrases();
  factory MLangPhrases.fromJson(Map<String, dynamic> json) =>
      _$MLangPhrasesFromJson(json);
  Map<String, dynamic> toJson() => _$MLangPhrasesToJson(this);
}

@JsonSerializable()
class MLangPhrase {
  @JsonKey(name: 'ID', includeFromJson: true, includeToJson: false)
  var id = 0;
  @JsonKey(name: 'LANGID')
  var langid = 0;
  @JsonKey(name: 'PHRASE')
  var phrase = "";
  @JsonKey(name: 'TRANSLATION')
  var translation = "";

  MLangPhrase();
  factory MLangPhrase.fromJson(Map<String, dynamic> json) =>
      _$MLangPhraseFromJson(json);
  Map<String, dynamic> toJson() => _$MLangPhraseToJson(this);
}
