import 'package:json_annotation/json_annotation.dart';

part 'mlangbloggp.g.dart';

@JsonSerializable()
class MLangBlogGPs {
  @JsonKey(name: 'records')
  List<MLangBlogGP> lst = [];

  MLangBlogGPs();

  factory MLangBlogGPs.fromJson(Map<String, dynamic> json) =>
      _$MLangBlogGPsFromJson(json);

  Map<String, dynamic> toJson() => _$MLangBlogGPsToJson(this);
}

@JsonSerializable()
class MLangBlogGP {
  @JsonKey(name: 'ID', includeFromJson: false, includeToJson: true)
  int id = 0;
  @JsonKey(name: 'GROUPID')
  int groupid = 0;
  @JsonKey(name: 'POSTID')
  int postid = 0;
  @JsonKey(name: 'GROUPNAME')
  String groupname = "";
  @JsonKey(name: 'TITLE')
  String title = "";
  @JsonKey(name: 'URL')
  String url = "";

  MLangBlogGP();

  factory MLangBlogGP.fromJson(Map<String, dynamic> json) =>
      _$MLangBlogGPFromJson(json);

  Map<String, dynamic> toJson() => _$MLangBlogGPToJson(this);
}
