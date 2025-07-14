import 'package:flutter_command/flutter_command.dart';
import 'package:lolly_flutter/models/blogs/mlangblogpost.dart';

class LangBlogPostsContentViewModel {
  List<MLangBlogPost> lstLangBlogPosts;
  final selectedLangBlogPostIndex_ =
      Command.createSync((int v) => v, initialValue: 0);
  int get selectedLangBlogPostIndex => selectedLangBlogPostIndex_.value;
  MLangBlogPost get selectedLangBlogPost =>
      lstLangBlogPosts[selectedLangBlogPostIndex];

  LangBlogPostsContentViewModel(this.lstLangBlogPosts, int index) {
    selectedLangBlogPostIndex_(index);
  }

  void next(int delta) => selectedLangBlogPostIndex_(
      (selectedLangBlogPostIndex + delta + lstLangBlogPosts.length) %
          lstLangBlogPosts.length);
}
