import 'package:json_annotation/json_annotation.dart';

part 'munitblogpost.g.dart';

@JsonSerializable()
class MUnitBlogPosts {
  @JsonKey(name: 'records')
  List<MUnitBlogPost> lst = [];

  MUnitBlogPosts();

  factory MUnitBlogPosts.fromJson(Map<String, dynamic> json) =>
      _$MUnitBlogPostsFromJson(json);

  Map<String, dynamic> toJson() => _$MUnitBlogPostsToJson(this);
}

@JsonSerializable()
class MUnitBlogPost {
  @JsonKey(name: 'ID', includeFromJson: false, includeToJson: true)
  int id = 0;
  @JsonKey(name: 'TEXTBOOKID')
  int textbookid = 0;
  @JsonKey(name: 'UNIT')
  int unit = 0;
  @JsonKey(name: 'CONTENT')
  var content = "";

  MUnitBlogPost();

  factory MUnitBlogPost.fromJson(Map<String, dynamic> json) =>
      _$MUnitBlogPostFromJson(json);

  Map<String, dynamic> toJson() => _$MUnitBlogPostToJson(this);
}
