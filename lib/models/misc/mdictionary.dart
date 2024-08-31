import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:lolly_flutter/services/misc/html_transform_service.dart';

import 'mautocorrect.dart';

part 'mdictionary.g.dart';

@JsonSerializable()
class MDictionaries {
  @JsonKey(name: 'records')
  List<MDictionary> lst = [];

  MDictionaries();

  factory MDictionaries.fromJson(Map<String, dynamic> json) =>
      _$MDictionariesFromJson(json);

  Map<String, dynamic> toJson() => _$MDictionariesToJson(this);
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
  @JsonKey(name: 'DICTTYPECODE')
  var dicttypecode = 0;
  @JsonKey(name: 'DICTTYPENAME')
  var dicttypename = "";
  @JsonKey(name: 'NAME')
  var dictname = "";
  @JsonKey(name: 'URL')
  var url = "";
  @JsonKey(name: 'CHCONV')
  var chconv = "";
  @JsonKey(name: 'AUTOMATION')
  var automation = "";
  @JsonKey(name: 'TRANSFORM')
  var transform = "";
  @JsonKey(name: 'WAIT')
  var wait = 0;
  @JsonKey(name: 'TEMPLATE')
  var template = "";
  @JsonKey(name: 'TEMPLATE2')
  var template2 = "";

  MDictionary();

  factory MDictionary.fromJson(Map<String, dynamic> json) =>
      _$MDictionaryFromJson(json);

  Map<String, dynamic> toJson() => _$MDictionaryToJson(this);

  String urlString(String word, List<MAutoCorrect> lstAutoCorrects) {
    final word2 = chconv == "BASIC"
        ? autoCorrect(word, lstAutoCorrects, (o) => o.extended, (o) => o.basic)
        : word;
    final wordUrl = url.replaceAll("{0}", Uri.encodeFull(word2));
    debugPrint("urlString: $wordUrl");
    return wordUrl;
  }

  String htmlString(String html, String word, bool useTemplate2) {
    final t = useTemplate2 && template2.isNotEmpty ? template2 : template;
    return HtmlTransformService.extractTextFromHtml(html, transform, t,
        (text, t) => HtmlTransformService.applyTemplate(t, word, text));
  }
}
