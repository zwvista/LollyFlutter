import 'package:flutter/cupertino.dart';
import 'package:lolly_flutter/models/wpp/mlangphrase.dart';

import '../misc/base_service.dart';

class LangPhraseService extends BaseService<MLangPhrase> {
  Future<List<MLangPhrase>> getDataByLang(int langid) async =>
      MLangPhrases.fromJson(await getDataByUrl(
              "LANGPHRASES?filter=LANGID,eq,$langid&order=PHRASE"))
          .lst;

  Future<int> create(MLangPhrase item) async =>
      await createByUrl("LANGPHRASES", item);

  Future<void> updateTranslation(int id, String translation) async =>
      debugPrint((await updateByUrlString(
              "LANGPHRASES/$id", "TRANSLATION=$translation"))
          .toString());

  Future<void> update(MLangPhrase item) async => debugPrint(
      (await callSPByUrl("LANGPHRASES/${item.id}", item)).toString());

  Future<void> delete(MLangPhrase item) async =>
      debugPrint((await callSPByUrl("LANGPHRASES_DELETE", item)).toString());
}
