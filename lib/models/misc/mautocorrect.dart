import 'package:json_annotation/json_annotation.dart';

part 'mautocorrect.g.dart';

@JsonSerializable()
class MAutoCorrects {
    @JsonKey(name: 'records')
    List<MAutoCorrect> lst;

    MAutoCorrects() {}
    factory MAutoCorrects.fromJson(Map<String, dynamic> json) => _$MAutoCorrectsFromJson(json);
    Map<String, dynamic> toJson() => _$MAutoCorrectsToJson(this);
}

@JsonSerializable()
class MAutoCorrect {
    @JsonKey(name: 'ID')
    var id = 0;
    @JsonKey(name: 'LANGID')
    var langid = 0;
    @JsonKey(name: 'SEQNUM')
    var seqnum = 0;
    @JsonKey(name: 'INPUT')
    var input = "";
    @JsonKey(name: 'EXTENDED')
    var extended = "";
    @JsonKey(name: 'BASIC')
    var basic = "";

    MAutoCorrect() {}
    factory MAutoCorrect.fromJson(Map<String, dynamic> json) => _$MAutoCorrectFromJson(json);
    Map<String, dynamic> toJson() => _$MAutoCorrectToJson(this);
}
