import 'package:flutter/cupertino.dart';
import 'package:lolly_flutter/models/blogs//munitblogpost.dart';

import '../misc/base_service.dart';

class UnitBlogPostService extends BaseService<MUnitBlogPost> {
  Future<MUnitBlogPost?> getDataByTextbook(int textbookid, int unit) async =>
      MUnitBlogPosts.fromJson(await getDataByUrl(
              "UNITBLOGPOSTS?filter=TEXTBOOKID,eq,$textbookid&filter=UNIT,eq,$unit"))
          .lst
          .firstOrNull;

  Future<void> _create(MUnitBlogPost item) async =>
      debugPrint((await createByUrl("UNITBLOGPOSTS", item)).toString());

  Future<void> _update(MUnitBlogPost item) async => debugPrint(
      (await updateByUrl("UNITBLOGPOSTS/${item.id}", item)).toString());

  Future<void> update(int textbookid, int unit, String content) async {
    final o = await getDataByTextbook(textbookid, unit);
    final item = o ?? MUnitBlogPost();
    if (item.id == 0) {
      item.textbookid = textbookid;
      item.unit = unit;
    }
    item.content = content;
    item.id == 0 ? await _create(item) : await _update(item);
  }
}
