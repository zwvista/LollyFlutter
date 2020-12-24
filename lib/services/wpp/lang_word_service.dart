import 'package:lolly_flutter/models/wpp/mlangword.dart';

import '../misc/base_service.dart';

class LangWordService extends BaseService<MLangWord> {
  Future<List<MLangWord>> getDataByLang(int langid) async =>
      MLangWords.fromJson(await getDataByUrl(
              "VLANGWORDS?filter=LANGID,eq,$langid&order=WORD"))
          .lst;

  Future<int> create(MLangWord item) async =>
      await createByUrl("LANGWORDS", item);

  Future updateNote(int id, String note) async =>
      print(await updateByUrlString("LANGWORDS/$id", "NOTE=$note"));

  Future update(MLangWord item) async =>
      print(await callSPByUrl("LANGWORDS/${item.id}", item));

  Future delete(MLangWord item) async =>
      print(await callSPByUrl("LANGWORDS_DELETE", item));
}
