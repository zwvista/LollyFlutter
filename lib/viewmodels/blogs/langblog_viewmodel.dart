import 'package:flutter_command/flutter_command.dart';

import '../../models/blogs/mlangbloggroup.dart';
import '../../models/blogs/mlangblogpost.dart';
import '../../services/blogs/langbloggroup_service.dart';
import '../../services/blogs/langblogpost_service.dart';

class LangBlogViewModel {
  List<MLangBlogGroup> lstLangBlogGroupsAll = [], lstLangBlogGroups = [];
  final langBlogGroupService = LangBlogGroupService();
  final groupFilter_ = Command.createSync((String v) => v, initialValue: "");
  String get groupFilter => groupFilter_.value;

  List<MLangBlogPost> lstLangBlogPostsAll = [], lstLangBlogPosts = [];
  final langBlogPostService = LangBlogPostService();
  final postFilter_ = Command.createSync((String v) => v, initialValue: "");
  String get postFilter => postFilter_.value;
}
