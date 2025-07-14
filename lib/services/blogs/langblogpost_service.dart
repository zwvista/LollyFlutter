import 'package:lolly_flutter/models/blogs/mlangblogpost.dart';

import '../../models/blogs/mlangbloggp.dart';
import '../misc/base_service.dart';

class LangBlogPostService extends BaseService<MLangBlogPost> {
  Future<List<MLangBlogPost>> getDataByLang(int langid) async {
    final res = await getDataByUrl(
      "LANGBLOGPOSTS?filter=LANGID,eq,$langid&order=TITLE",
    );
    return MLangBlogPosts.fromJson(res).lst;
  }

  Future<List<MLangBlogPost>> getDataByLangGroup(
      int langid, int groupid) async {
    final res = await getDataByUrl(
      "VLANGBLOGGP?filter=LANGID,eq,$langid&filter=GROUPID,eq,$groupid&order=TITLE",
    );
    final list = MLangBlogGPs.fromJson(res).lst;

    final groups = <int, MLangBlogPost>{};
    for (final gp in list) {
      groups[gp.postid] = MLangBlogPost()
        ..id = gp.postid
        ..langid = langid
        ..title = gp.title
        ..url = gp.url
        ..gpid = gp.id;
    }
    return groups.values.toList();
  }

  Future<int> create(MLangBlogPost item) async =>
      createByUrl("LANGBLOGPOSTS", item).logCreate();

  Future<void> update(MLangBlogPost item) async =>
      updateByUrl("LANGBLOGPOSTS/${item.id}", item).logUpdate(item.id);

  Future<void> delete(int id) async =>
      deleteByUrl("LANGBLOGPOSTS/$id").logDelete();
}
