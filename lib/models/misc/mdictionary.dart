import 'package:json_annotation/json_annotation.dart';

part 'mdictionary.g.dart';

@JsonSerializable()
class MDictsReference {
    @JsonKey(name: 'records')
    List<MDictionary> lst;

    MDictsReference() {}
    factory MDictsReference.fromJson(Map<String, dynamic> json) => _$MDictsReferenceFromJson(json);
    Map<String, dynamic> toJson() => _$MDictsReferenceToJson(this);
}

@JsonSerializable()
class MDictsNote {
    @JsonKey(name: 'records')
    List<MDictionary> lst;

    MDictsNote() {}
    factory MDictsNote.fromJson(Map<String, dynamic> json) => _$MDictsNoteFromJson(json);
    Map<String, dynamic> toJson() => _$MDictsNoteToJson(this);
}

@JsonSerializable()
class MDictsTranslation {
    @JsonKey(name: 'records')
    List<MDictionary> lst;

    MDictsTranslation() {}
    factory MDictsTranslation.fromJson(Map<String, dynamic> json) => _$MDictsTranslationFromJson(json);
    Map<String, dynamic> toJson() => _$MDictsTranslationToJson(this);
}

@JsonSerializable()
class MDictionary {
    @JsonKey(name: 'ID')
    var id = 0;
    @JsonKey(name: 'DICTID')
    var dictid = 0;
    @JsonKey(name: 'LANGIDFROM')
    var langidfrom = 0;
    @JsonKey(name: 'LANGNAMEFROM')
    var langnamefrom = "";
    @JsonKey(name: 'LANGIDTO')
    var langidto = 0;
    @JsonKey(name: 'LANGNAMETO')
    var langnameto = "";
    @JsonKey(name: 'SEQNUM')
    var seqnum = 0;
    @JsonKey(name: 'DICTTYPEID')
    var dicttypeid = 0;
    @JsonKey(name: 'DICTTYPENAME')
    var dicttypename = "";
    @JsonKey(name: 'DICTNAME')
    var dictname = "";
    @JsonKey(name: 'URL')
    String url;
    @JsonKey(name: 'CHCONV')
    String chconv;
    @JsonKey(name: 'AUTOMATION')
    String automation;
    @JsonKey(name: 'TRANSFORM')
    String transform;
    @JsonKey(name: 'WAIT')
    var wait = 0;
    @JsonKey(name: 'TEMPLATE')
    String template;
    @JsonKey(name: 'TEMPLATE2')
    String template2;

    MDictionary() {}
    factory MDictionary.fromJson(Map<String, dynamic> json) => _$MDictionaryFromJson(json);
    Map<String, dynamic> toJson() => _$MDictionaryToJson(this);
}

const cssFolder = "https://zwvista.tk/lolly/css/";
