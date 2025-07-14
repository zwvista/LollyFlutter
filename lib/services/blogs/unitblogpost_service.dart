import 'package:lolly_flutter/models/blogs/munitblogpost.dart';

import '../misc/base_service.dart';

class UnitBlogPostService extends BaseService<MUnitBlogPost> {
  Future<MUnitBlogPost?> getDataByTextbook(int textbookid, int unit) async {
    final res = await getDataByUrl(
        "UNITBLOGPOSTS?filter=TEXTBOOKID,eq,$textbookid&filter=UNIT,eq,$unit");
    return MUnitBlogPosts.fromJson(res).lst.firstOrNull;
  }

  Future<int> _create(MUnitBlogPost item) async =>
      createByUrl("UNITBLOGPOSTS", item).logCreate();

  Future<void> _update(MUnitBlogPost item) async =>
      updateByUrl("UNITBLOGPOSTS/${item.id}", item).logUpdate(item.id);

  Future<void> update(int textbookid, int unit, String content) async {
    final item = await getDataByTextbook(textbookid, unit) ?? MUnitBlogPost()
      ..textbookid = textbookid
      ..unit = unit;
    item.content = content;
    item.id == 0 ? await _create(item) : await _update(item);
  }

  Future<void> delete(int id) async =>
      deleteByUrl("UNITBLOGPOSTS/$id").logDelete();
}
