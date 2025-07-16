import 'package:flutter_command/flutter_command.dart';
import 'package:lolly_flutter/main.dart';

import '../../models/blogs/mlangbloggroup.dart';
import '../../models/blogs/mlangblogpost.dart';
import 'langblog_viewmodel.dart';

class LangBlogGroupsViewModel extends LangBlogViewModel {
  var reloadedGroups = false;
  late Command<void, List<MLangBlogGroup>> reloadGroupsCommand;
  var reloadedPosts = false;
  late Command<void, List<MLangBlogPost>> reloadPostsCommand;

  LangBlogGroupsViewModel() {
    reloadGroupsCommand = Command.createAsyncNoParam(() async {
      if (!reloadedGroups) {
        lstLangBlogGroupsAll = await langBlogGroupService
            .getDataByLang(vmSettings.selectedLang!.id);
        reloadedGroups = true;
      }
      lstLangBlogGroups = groupFilter.isEmpty
          ? lstLangBlogGroupsAll
          : lstLangBlogGroupsAll
              .where((o) =>
                  o.groupname.toLowerCase().contains(groupFilter.toLowerCase()))
              .toList();
      return lstLangBlogGroups;
    }, initialValue: []);
    groupFilter_.listen((v, _) => reloadGroupsCommand());

    reloadPostsCommand = Command.createAsyncNoParam(() async {
      if (!reloadedPosts) {
        lstLangBlogPostsAll = await langBlogPostService.getDataByLangGroup(
            vmSettings.selectedLang!.id, selectedGroup?.id ?? 0);
        reloadedPosts = true;
      }
      lstLangBlogPosts = postFilter.isEmpty
          ? lstLangBlogPostsAll
          : lstLangBlogPostsAll
              .where((o) =>
                  o.title.toLowerCase().contains(postFilter.toLowerCase()))
              .toList();
      return lstLangBlogPosts;
    }, initialValue: []);
    postFilter_.listen((v, _) => reloadPostsCommand());
    selectedGroup_.listen((v, _) => reloadPostsCommand());
  }
}
