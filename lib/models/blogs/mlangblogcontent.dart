import 'package:json_annotation/json_annotation.dart';

part 'mlangblogcontent.g.dart';

@JsonSerializable()
class MLangBlogsContent {
  @JsonKey(name: 'records')
  List<MLangBlogPostContent> lst = [];

  MLangBlogsContent();

  factory MLangBlogsContent.fromJson(Map<String, dynamic> json) =>
      _$MLangBlogsContentFromJson(json);

  Map<String, dynamic> toJson() => _$MLangBlogsContentToJson(this);
}

@JsonSerializable()
class MLangBlogPostContent {
  @JsonKey(name: 'ID', includeFromJson: false, includeToJson: true)
  int id = 0;
  @JsonKey(name: 'TITLE')
  String title = "";
  @JsonKey(name: 'CONTENT')
  String content = "";

  MLangBlogPostContent();

  factory MLangBlogPostContent.fromJson(Map<String, dynamic> json) =>
      _$MLangBlogPostContentFromJson(json);

  Map<String, dynamic> toJson() => _$MLangBlogPostContentToJson(this);
}
