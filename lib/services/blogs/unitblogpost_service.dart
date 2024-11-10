import 'package:flutter/cupertino.dart';
import 'package:lolly_flutter/models/blogs//munitblogpost.dart';

import '../misc/base_service.dart';

class UnitBlogPostService extends BaseService<MUnitBlogPost> {
  Future<List<MUnitBlogPost>> getDataByTextbook(
          int textbookid, int unit) async =>
      MUnitBlogPosts.fromJson(await getDataByUrl(
              "UNITBLOGPOSTS?filter=TEXTBOOKID,eq,$textbookid&filter=UNIT,eq,$unit"))
          .lst;

  Future<int> create(MUnitBlogPost item) async =>
      await createByUrl("UNITBLOGPOSTS", item);

  Future update(MUnitBlogPost item) async => debugPrint(
      (await updateByUrl("UNITBLOGPOSTS/${item.id}", item)).toString());
}
