import 'package:lolly_flutter/models/wpp/mpatternwebpage.dart';
import 'package:lolly_flutter/models/wpp/mwebPage.dart';

import '../misc/base_service.dart';

class WebPageService extends BaseService<MWebPage> {
  Future<List<MWebPage>> getDataBySearch(String title, String url) async {
    var filter = "";
    if (title.isNotEmpty)
      filter += "?filter=TITLE,cs,${Uri.encodeComponent(title)}";
    if (url.isNotEmpty)
      filter += (filter.isEmpty ? "?" : "&") +
          "filter=URL,cs,${Uri.encodeComponent(url)}";
    return MWebPages.fromJson(await getDataByUrl("WEBPAGES$filter")).lst;
  }

  Future<MWebPage> getDataById(int id) async =>
      MWebPages.fromJson(await getDataByUrl("PATTERNS?filter=ID,eq,$id"))
          .lst
          .firstWhere((_) => true, orElse: () => null);

  Future<int> createByPattern(MPatternWebPage item) async {
    final item2 = MWebPage()
      ..title = item.title
      ..url = item.url;
    return await createByUrl("WEBPAGES", item2);
  }

  Future<int> create(MWebPage item) async =>
      await createByUrl("WEBPAGES", item);

  Future updateByPattern(MPatternWebPage item) async {
    final item2 = MWebPage()
      ..title = item.title
      ..url = item.url;
    print(await updateByUrl("WEBPAGES/${item.id}", item2));
  }

  Future update(MWebPage item) async =>
      print(await updateByUrl("WEBPAGES/${item.id}", item));

  Future delete(int id) async => print(await deleteByUrl("WEBPAGES/$id"));
}
