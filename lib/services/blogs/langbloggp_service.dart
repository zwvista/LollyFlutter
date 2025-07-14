import 'package:lolly_flutter/models/blogs/mlangbloggp.dart';

import '../misc/base_service.dart';

class LangBlogGPService extends BaseService<MLangBlogGP> {
  Future<int> create(MLangBlogGP item) async =>
      createByUrl("LANGBLOGGP", item).logCreate();

  Future<void> update(MLangBlogGP item) async =>
      updateByUrl("LANGBLOGGP/${item.id}", item).logUpdate(item.id);

  Future<void> delete(int id) async =>
      deleteByUrl("LANGBLOGGP/$id").logDelete();
}
