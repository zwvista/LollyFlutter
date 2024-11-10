import 'package:flutter/cupertino.dart';
import 'package:lolly_flutter/models/wpp/mlangword.dart';

import '../misc/base_service.dart';

class LangWordService extends BaseService<MLangWord> {
  Future<List<MLangWord>> getDataByLang(int langid) async =>
      MLangWords.fromJson(await getDataByUrl(
              "VLANGWORDS?filter=LANGID,eq,$langid&order=WORD"))
          .lst;

  Future<int> create(MLangWord item) async =>
      await createByUrl("LANGWORDS", item);

  Future<void> updateNote(int id, String note) async => debugPrint(
      (await updateByUrlString("LANGWORDS/$id", "NOTE=$note")).toString());

  Future<void> update(MLangWord item) async =>
      debugPrint((await callSPByUrl("LANGWORDS/${item.id}", item)).toString());

  Future<void> delete(MLangWord item) async =>
      debugPrint((await callSPByUrl("LANGWORDS_DELETE", item)).toString());
}
