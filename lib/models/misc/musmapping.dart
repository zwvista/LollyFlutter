import 'package:json_annotation/json_annotation.dart';

part 'musmapping.g.dart';

@JsonSerializable()
class MUSMappings {
    @JsonKey(name: 'records')
    List<MUSMapping> lst;

    MUSMappings() {}
    factory MUSMappings.fromJson(Map<String, dynamic> json) => _$MUSMappingsFromJson(json);
    Map<String, dynamic> toJson() => _$MUSMappingsToJson(this);
}

@JsonSerializable()
class MUSMapping {
    @JsonKey(name: 'ID')
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

    MUSMapping() {}
    factory MUSMapping.fromJson(Map<String, dynamic> json) => _$MUSMappingFromJson(json);
    Map<String, dynamic> toJson() => _$MUSMappingToJson(this);

    static final NAME_USLANGID = "USLANGID";
    static final NAME_USROWSPERPAGEOPTIONS = "USROWSPERPAGEOPTIONS";
    static final NAME_USROWSPERPAGE = "USROWSPERPAGE";
    static final NAME_USLEVELCOLORS = "USLEVELCOLORS";
    static final NAME_USSCANINTERVAL = "USSCANINTERVAL";
    static final NAME_USREVIEWINTERVAL = "USREVIEWINTERVAL";

    static final NAME_USTEXTBOOKID = "USTEXTBOOKID";
    static final NAME_USDICTREFERENCE = "USDICTREFERENCE";
    static final NAME_USDICTNOTE = "USDICTNOTE";
    static final NAME_USDICTSREFERENCE = "USDICTSREFERENCE";
    static final NAME_USDICTTRANSLATION = "USDICTTRANSLATION";
    static final NAME_USMACVOICEID = "USMACVOICEID";
    static final NAME_USIOSVOICEID = "USIOSVOICEID";
    static final NAME_USANDROIDVOICEID = "USANDROIDVOICEID";
    static final NAME_USWEBVOICEID = "USWEBVOICEID";
    static final NAME_USWINDOWSVOICEID = "USWINDOWSVOICEID";

    static final NAME_USUNITFROM = "USUNITFROM";
    static final NAME_USPARTFROM = "USPARTFROM";
    static final NAME_USUNITTO = "USUNITTO";
    static final NAME_USPARTTO = "USPARTTO";

}

