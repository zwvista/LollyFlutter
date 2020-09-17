import 'dart:convert';

import 'package:lolly_flutter/models/wpp/mlangword.dart';

import '../misc/baseservice.dart';

class LangWordService extends BaseService {
  Future<List<MLangWord>> getDataByLang(int langid) async =>
      MLangWords.fromJson(await getDataByUrl(
              "VLANGWORDS?filter=LANGID,eq,$langid&order=WORD"))
          .lst;

  Future<int> create(MLangWord item) async =>
      await createByUrl("LANGWORDS", json.encode(item));

  Future updateNote(int id, String note) async =>
      print(await updateByUrl("LANGWORDS/$id", "NOTE=$note"));

  Future update(MLangWord item) async =>
      print(await callSPByUrl("LANGWORDS/${item.id}", json.encode(item)));

  Future delete(MLangWord item) async =>
      print(await callSPByUrl("LANGWORDS_DELETE", json.encode(item)));
}
