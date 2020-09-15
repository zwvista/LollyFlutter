import 'package:json_annotation/json_annotation.dart';

part 'mlanguage.g.dart';

@JsonSerializable()
class MLanguages {
    @JsonKey(name: 'records')
    List<MLanguage> lst;

    MLanguages() {}
    factory MLanguages.fromJson(Map<String, dynamic> json) => _$MLanguagesFromJson(json);
    Map<String, dynamic> toJson() => _$MLanguagesToJson(this);
}

@JsonSerializable()
class MLanguage {
    @JsonKey(name: 'ID')
    var id = 0;
    @JsonKey(name: 'NAME')
    String langname;
    @JsonKey(name: 'VOICE')
    String voice;

    MLanguage() {}
    factory MLanguage.fromJson(Map<String, dynamic> json) => _$MLanguageFromJson(json);
    Map<String, dynamic> toJson() => _$MLanguageToJson(this);
}
