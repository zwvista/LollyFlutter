import 'package:lolly_flutter/models/blogs/mlangbloggp.dart';
import 'package:lolly_flutter/models/blogs/mlangbloggroup.dart';

import '../misc/base_service.dart';

class LangBlogGroupService extends BaseService<MLangBlogGroup> {
  Future<List<MLangBlogGroup>> getDataByLang(int langid) async {
    final res = await getDataByUrl(
      "LANGBLOGGROUPS?filter=LANGID,eq,$langid&order=NAME",
    );
    return MLangBlogGroups.fromJson(res).lst;
  }

  Future<List<MLangBlogGroup>> getDataByLangPost(int langid, int postid) async {
    final res = await getDataByUrl(
      "VLANGBLOGGP?filter=LANGID,eq,$langid&filter=POSTID,eq,$postid&order=GROUPNAME",
    );
    final list = MLangBlogGPs.fromJson(res).lst;

    final groups = <int, MLangBlogGroup>{};
    for (final gp in list) {
      groups[gp.groupid] = MLangBlogGroup()
        ..id = gp.groupid
        ..langid = langid
        ..groupname = gp.groupname
        ..gpid = gp.id;
    }
    return groups.values.toList();
  }

  Future<int> create(MLangBlogGroup item) async =>
      createByUrl("LANGBLOGGROUPS", item).logCreate();

  Future<void> update(MLangBlogGroup item) async =>
      updateByUrl("LANGBLOGGROUPS/${item.id}", item).logUpdate(item.id);

  Future<void> delete(int id) async =>
      deleteByUrl("LANGBLOGGROUPS/$id").logDelete();
}
