import 'package:json_annotation/json_annotation.dart';

part 'mlangbloggroup.g.dart';

@JsonSerializable()
class MLangBlogGroups {
  @JsonKey(name: 'records')
  List<MLangBlogGroup> lst = [];

  MLangBlogGroups();

  factory MLangBlogGroups.fromJson(Map<String, dynamic> json) =>
      _$MLangBlogGroupsFromJson(json);

  Map<String, dynamic> toJson() => _$MLangBlogGroupsToJson(this);
}

@JsonSerializable()
class MLangBlogGroup {
  @JsonKey(name: 'ID', includeFromJson: true, includeToJson: false)
  int id = 0;
  @JsonKey(name: 'LANGID')
  int langid = 0;
  @JsonKey(name: 'NAME')
  String groupname = "";
  @JsonKey(includeFromJson: false, includeToJson: false)
  int gpid = 0;

  MLangBlogGroup();

  factory MLangBlogGroup.fromJson(Map<String, dynamic> json) =>
      _$MLangBlogGroupFromJson(json);

  Map<String, dynamic> toJson() => _$MLangBlogGroupToJson(this);
}
