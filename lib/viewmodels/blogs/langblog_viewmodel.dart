import 'package:flutter_command/flutter_command.dart';
import 'package:lolly_flutter/services/blogs/langblogpostcontent_service.dart';

import '../../models/blogs/mlangbloggroup.dart';
import '../../models/blogs/mlangblogpost.dart';
import '../../services/blogs/blog_service.dart';
import '../../services/blogs/langbloggroup_service.dart';
import '../../services/blogs/langblogpost_service.dart';

class LangBlogViewModel {
  List<MLangBlogGroup> lstLangBlogGroupsAll = [], lstLangBlogGroups = [];
  final langBlogGroupService = LangBlogGroupService();
  final groupFilter_ = Command.createSync((String v) => v, initialValue: "");
  String get groupFilter => groupFilter_.value;
  final selectedGroup_ = Command.createSync((MLangBlogGroup? v) => v, initialValue: null);
  MLangBlogGroup? get selectedGroup => selectedGroup_.value;

  List<MLangBlogPost> lstLangBlogPostsAll = [], lstLangBlogPosts = [];
  final langBlogPostService = LangBlogPostService();
  final postFilter_ = Command.createSync((String v) => v, initialValue: "");
  String get postFilter => postFilter_.value;
  final selectedPost_ = Command.createSync((MLangBlogPost? v) => v, initialValue: null);
  MLangBlogPost? get selectedPost => selectedPost_.value;

  final langBlogPostHtml = Command.createSync((String v) => v, initialValue: "");
  final blogService = BlogService();
  final contentService = LangBlogPostContentService();

  LangBlogViewModel() {
    selectedPost_.listen((v, _) async {
      final content = (await contentService.getDataById(v?.id ?? 0))?.content ?? "";
      final str = blogService.markedToHtml(content);
      langBlogPostHtml(str);
    });
  }

}
