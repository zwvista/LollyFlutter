import 'package:lolly_flutter/models/wpp/mpatternwebpage.dart';

import '../misc/base_service.dart';

class PatternWebPageService extends BaseService<MPatternWebPage> {
  Future<List<MPatternWebPage>> getDataByPattern(int patternid) async =>
      MPatternWebPages.fromJson(await getDataByUrl(
              "VPATTERNSWEBPAGES?filter=PATTERNID,eq,$patternid&order=SEQNUM"))
          .lst;

  Future<MPatternWebPage> getDataById(int id) async =>
      MPatternWebPages.fromJson(
              await getDataByUrl("VPATTERNSWEBPAGES?filter=ID,eq,$id"))
          .lst
          .firstWhere((_) => true, orElse: () => null);

  Future<int> create(MPatternWebPage item) async =>
      await createByUrl("PATTERNSWEBPAGES", item);

  Future updateSeqNum(int id, int seqnum) async =>
      print(await updateByUrlString("PATTERNSWEBPAGES/$id", "SEQNUM=$seqnum"));

  Future update(MPatternWebPage item) async =>
      print(await updateByUrl("PATTERNSWEBPAGES/${item.id}", item));

  Future delete(int id) async =>
      print(await deleteByUrl("PATTERNSWEBPAGES/$id"));
}
