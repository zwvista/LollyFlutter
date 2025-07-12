import 'package:json_annotation/json_annotation.dart';

part 'mlangblogpost.g.dart';

@JsonSerializable()
class MLangBlogPosts {
  @JsonKey(name: 'records')
  List<MLangBlogPost> lst = [];

  MLangBlogPosts();

  factory MLangBlogPosts.fromJson(Map<String, dynamic> json) =>
      _$MLangBlogPostsFromJson(json);

  Map<String, dynamic> toJson() => _$MLangBlogPostsToJson(this);
}

@JsonSerializable()
class MLangBlogPost {
  @JsonKey(name: 'ID', includeFromJson: false, includeToJson: true)
  int id = 0;
  @JsonKey(name: 'LANGID')
  int langid = 0;
  @JsonKey(name: 'TITLE')
  String title = "";
  @JsonKey(name: 'URL')
  String url = "";
  @JsonKey(includeFromJson: false, includeToJson: false)
  int gpid = 0;

  MLangBlogPost();

  factory MLangBlogPost.fromJson(Map<String, dynamic> json) =>
      _$MLangBlogPostFromJson(json);

  Map<String, dynamic> toJson() => _$MLangBlogPostToJson(this);
}
