import 'package:json_annotation/json_annotation.dart';

part 'mlangblogpostcontent.g.dart';

@JsonSerializable()
class MLangBlogPostContents {
  @JsonKey(name: 'records')
  List<MLangBlogPostContent> lst = [];

  MLangBlogPostContents();

  factory MLangBlogPostContents.fromJson(Map<String, dynamic> json) =>
      _$MLangBlogPostContentsFromJson(json);

  Map<String, dynamic> toJson() => _$MLangBlogPostContentsToJson(this);
}

@JsonSerializable()
class MLangBlogPostContent {
  @JsonKey(name: 'ID', includeFromJson: true, includeToJson: false)
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
