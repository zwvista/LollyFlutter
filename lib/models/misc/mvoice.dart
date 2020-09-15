import 'package:json_annotation/json_annotation.dart';

part 'mvoice.g.dart';

@JsonSerializable()
class MVoices {
    @JsonKey(name: 'records')
    List<MVoice> lst;

    MVoices() {}
    factory MVoices.fromJson(Map<String, dynamic> json) => _$MVoicesFromJson(json);
    Map<String, dynamic> toJson() => _$MVoicesToJson(this);
}

@JsonSerializable()
class MVoice {
    @JsonKey(name: 'ID')
    var id = 0;
    @JsonKey(name: 'LANGID')
    var langid = 0;
    @JsonKey(name: 'VOICETYPEID')
    var voicetypeid = 0;
    @JsonKey(name: 'VOICELANG')
    String voicelang;
    @JsonKey(name: 'VOICENAME')
    var voicename = "";

    MVoice() {}
    factory MVoice.fromJson(Map<String, dynamic> json) => _$MVoiceFromJson(json);
    Map<String, dynamic> toJson() => _$MVoiceToJson(this);
}
