import 'dart:convert';

import 'package:lolly_flutter/models/wpp/mlangphrase.dart';

import '../misc/baseservice.dart';

class LangPhraseService extends BaseService {
  Future<List<MLangPhrase>> getDataByLang(int langid) async =>
      MLangPhrases.fromJson(await getDataByUrl(
              "LANGPHRASES?filter=LANGID,eq,$langid&order=PHRASE"))
          .lst;

  Future<int> create(MLangPhrase item) async =>
      await createByUrl("LANGPHRASES", json.encode(item));

  Future updateTranslation(int id, String translation) async =>
      print(await updateByUrl("LANGPHRASES/$id", "TRANSLATION=$translation"));

  Future update(MLangPhrase item) async =>
      print(await callSPByUrl("LANGPHRASES/${item.id}", json.encode(item)));

  Future delete(MLangPhrase item) async =>
      print(await callSPByUrl("LANGPHRASES_DELETE", json.encode(item)));
}
