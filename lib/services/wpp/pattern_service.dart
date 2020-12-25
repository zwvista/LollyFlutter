import 'package:lolly_flutter/models/wpp/mpattern.dart';

import '../misc/base_service.dart';

class PatternService extends BaseService<MPattern> {
  Future<List<MPattern>> getDataByLang(int langid) async => MPatterns.fromJson(
          await getDataByUrl("PATTERNS?filter=LANGID,eq,$langid&order=PATTERN"))
      .lst;

  Future<MPattern> getDataById(int id) async =>
      MPatterns.fromJson(await getDataByUrl("PATTERNS?filter=ID,eq,$id"))
          .lst
          .firstWhere((_) => true, orElse: () => null);

  Future<int> create(MPattern item) async =>
      await createByUrl("PATTERNS", item);

  Future update(MPattern item) async =>
      print(await updateByUrl("PATTERNS/${item.id}", item));

  Future delete(int id) async => print(await deleteByUrl("PATTERNS/$id"));

  Future mergePatterns(MPattern item) async =>
      print(await callSPByUrl("PATTERNS_MERGE", item));

  Future splitPattern(MPattern item) async =>
      print(await callSPByUrl("PATTERNS_SPLIT", item));
}
