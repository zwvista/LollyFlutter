import 'package:lolly_flutter/models/blogs/mlangblogpostcontent.dart';

import '../misc/base_service.dart';

class LangBlogPostContentService extends BaseService<MLangBlogPostContent> {
  Future<MLangBlogPostContent?> getDataById(int id) async {
    final res = await getDataByUrl("LANGBLOGPOSTS?filter=ID,eq,$id");
    return MLangBlogPostContents.fromJson(res).lst.firstOrNull;
  }

  Future<void> update(MLangBlogPostContent item) async =>
      updateByUrl("LANGBLOGPOSTS/${item.id}", item).logUpdate(item.id);
}
