import 'package:flutter/cupertino.dart';
import 'package:lolly_flutter/models/wpp/mpattern.dart';

import '../../main.dart';
import '../misc/base_service.dart';

class PatternService extends BaseService<MPattern> {
  Future<List<MPattern>> getDataByLang(int langid) async => MPatterns.fromJson(
          await getDataByUrl("PATTERNS?filter=LANGID,eq,$langid&order=PATTERN"))
      .lst;

  Future<MPattern?> getDataById(int id) async =>
      MPatterns.fromJson(await getDataByUrl("PATTERNS?filter=ID,eq,$id"))
          .lst
          .firstWhereOrNull((_) => true);

  Future<int> create(MPattern item) async =>
      await createByUrl("PATTERNS", item);

  Future update(MPattern item) async =>
      debugPrint((await updateByUrl("PATTERNS/${item.id}", item)).toString());

  Future delete(int id) async =>
      debugPrint((await deleteByUrl("PATTERNS/$id")).toString());

  Future mergePatterns(MPattern item) async =>
      debugPrint((await callSPByUrl("PATTERNS_MERGE", item)).toString());

  Future splitPattern(MPattern item) async =>
      debugPrint((await callSPByUrl("PATTERNS_SPLIT", item)).toString());
}
