import 'package:json_annotation/json_annotation.dart';

part 'musmapping.g.dart';

@JsonSerializable()
class MUSMappings {
  @JsonKey(name: 'records')
  List<MUSMapping> lst = [];

  MUSMappings();

  factory MUSMappings.fromJson(Map<String, dynamic> json) =>
      _$MUSMappingsFromJson(json);

  Map<String, dynamic> toJson() => _$MUSMappingsToJson(this);
}

@JsonSerializable()
class MUSMapping {
  @JsonKey(name: 'ID', includeFromJson: false, includeToJson: true)
  var id = 0;
  @JsonKey(name: 'NAME')
  var name = "";
  @JsonKey(name: 'KIND')
  var kind = 0;
  @JsonKey(name: 'ENTITYID')
  var entityid = 0;
  @JsonKey(name: 'VALUEID')
  var valueid = 0;
  @JsonKey(name: 'LEVEL')
  var level = 0;

  MUSMapping();

  factory MUSMapping.fromJson(Map<String, dynamic> json) =>
      _$MUSMappingFromJson(json);

  Map<String, dynamic> toJson() => _$MUSMappingToJson(this);

  static const NAME_USLANG = "USLANG";
  static const NAME_USROWSPERPAGEOPTIONS = "USROWSPERPAGEOPTIONS";
  static const NAME_USROWSPERPAGE = "USROWSPERPAGE";
  static const NAME_USLEVELCOLORS = "USLEVELCOLORS";
  static const NAME_USSCANINTERVAL = "USSCANINTERVAL";
  static const NAME_USREVIEWINTERVAL = "USREVIEWINTERVAL";

  static const NAME_USTEXTBOOK = "USTEXTBOOK";
  static const NAME_USDICTREFERENCE = "USDICTREFERENCE";
  static const NAME_USDICTNOTE = "USDICTNOTE";
  static const NAME_USDICTSREFERENCE = "USDICTSREFERENCE";
  static const NAME_USDICTTRANSLATION = "USDICTTRANSLATION";
  static const NAME_USVOICE = "USFLUTTERVOICE";

  static const NAME_USUNITFROM = "USUNITFROM";
  static const NAME_USPARTFROM = "USPARTFROM";
  static const NAME_USUNITTO = "USUNITTO";
  static const NAME_USPARTTO = "USPARTTO";
}
