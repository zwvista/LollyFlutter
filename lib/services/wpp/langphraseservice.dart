import 'package:lolly_flutter/models/wpp/mlangphrase.dart';

import '../misc/baseservice.dart';

class LangPhraseService extends BaseService<MLangPhrase> {
  Future<List<MLangPhrase>> getDataByLang(int langid) async =>
      MLangPhrases.fromJson(await getDataByUrl(
              "LANGPHRASES?filter=LANGID,eq,$langid&order=PHRASE"))
          .lst;

  Future<int> create(MLangPhrase item) async =>
      await createByUrl("LANGPHRASES", item);

  Future updateTranslation(int id, String translation) async => print(
      await updateByUrlString("LANGPHRASES/$id", "TRANSLATION=$translation"));

  Future update(MLangPhrase item) async =>
      print(await callSPByUrl("LANGPHRASES/${item.id}", item));

  Future delete(MLangPhrase item) async =>
      print(await callSPByUrl("LANGPHRASES_DELETE", item));
}
