import 'package:flutter_command/flutter_command.dart';
import 'package:lolly_flutter/main.dart';

import '../../models/blogs/mlangbloggroup.dart';
import '../../models/blogs/mlangblogpost.dart';
import 'langblog_viewmodel.dart';

class LangBlogGroupsViewModel extends LangBlogViewModel {
  var reloaded = false;
  late Command<void, List<MLangBlogGroup>> reloadCommand;
  late Command<MLangBlogGroup, List<MLangBlogPost>> selectGroupCommand;

  LangBlogGroupsViewModel() {
    reloadCommand = Command.createAsyncNoParam(() async {
      if (!reloaded) {
        lstLangBlogGroupsAll = await langBlogGroupService
            .getDataByLang(vmSettings.selectedLang!.id);
        reloaded = true;
      }
      lstLangBlogGroups = groupFilter.isEmpty
          ? lstLangBlogGroupsAll
          : lstLangBlogGroupsAll
              .where((o) =>
                  o.groupname.toLowerCase().contains(groupFilter.toLowerCase()))
              .toList();
      return lstLangBlogGroups;
    }, initialValue: []);
    groupFilter_.listen((v, _) => reloadCommand());

    selectGroupCommand = Command.createAsync((MLangBlogGroup group) async {
      lstLangBlogPostsAll =
          await langBlogPostService.getDataByLang(vmSettings.selectedLang!.id);
      lstLangBlogPosts = postFilter.isEmpty
          ? lstLangBlogPostsAll
          : lstLangBlogPostsAll
              .where((o) =>
                  o.title.toLowerCase().contains(postFilter.toLowerCase()))
              .toList();
      return lstLangBlogPosts;
    }, initialValue: []);
  }
}
