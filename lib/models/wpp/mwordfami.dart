import 'package:json_annotation/json_annotation.dart';

part 'mwordfami.g.dart';

@JsonSerializable()
class MWordsFami {
  @JsonKey(name: 'records')
  List<MWordFami> lst;

  MWordsFami();
  factory MWordsFami.fromJson(Map<String, dynamic> json) =>
      _$MWordsFamiFromJson(json);
  Map<String, dynamic> toJson() => _$MWordsFamiToJson(this);
}

@JsonSerializable()
class MWordFami {
  @JsonKey(name: 'ID')
  var id = 0;
  @JsonKey(name: 'USERID')
  var userid = "";
  @JsonKey(name: 'WORDID')
  var wordid = 0;
  @JsonKey(name: 'CORRECT')
  var correct = 0;
  @JsonKey(name: 'TOTAL')
  var total = 0;

  MWordFami();
  factory MWordFami.fromJson(Map<String, dynamic> json) =>
      _$MWordFamiFromJson(json);
  Map<String, dynamic> toJson() => _$MWordFamiToJson(this);
}
