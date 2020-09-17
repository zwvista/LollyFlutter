import 'dart:convert';

import 'package:lolly_flutter/models/misc/mtextbook.dart';
import 'package:lolly_flutter/models/wpp/munitphrase.dart';

import '../misc/baseservice.dart';

class UnitPhraseService extends BaseService {
  Future<List<MUnitPhrase>> getDataByTextbookUnitPart(
      MTextbook textbook, int unitPartFrom, int unitPartTo) async {
    final lst = MUnitPhrases.fromJson(await getDataByUrl(
            "VUNITPHRASES?filter=TEXTBOOKID,eq,${textbook.id}&filter=UNITPART,bt,$unitPartFrom,$unitPartTo&order=UNITPART&order=SEQNUM"))
        .lst;
    for (var o in lst) o.textbook = textbook;
    return lst;
  }

  List<MUnitPhrase> _setTextbook(
      List<MUnitPhrase> lst, List<MTextbook> lstTextbooks) {
    for (var o in lst)
      o.textbook = lstTextbooks.firstWhere((o3) => o3.id == o.textbookid);
    return lst;
  }

  Future<List<MUnitPhrase>> getDataByLang(
      int langid, List<MTextbook> lstTextbooks) async {
    final lst = MUnitPhrases.fromJson(await getDataByUrl(
            "VUNITPHRASES?filter=LANGID,eq,$langid&order=TEXTBOOKID&order=UNIT&order=PART&order=SEQNUM"))
        .lst;
    return _setTextbook(lst, lstTextbooks);
  }

  Future<MUnitPhrase> getDataById(int id, List<MTextbook> lstTextbooks) async {
    var lst = MUnitPhrases.fromJson(
            await getDataByUrl("VUNITPHRASES?filter=ID,eq,$id"))
        .lst;
    lst = _setTextbook(lst, lstTextbooks);
    return lst.isNotEmpty ? lst[0] : null;
  }

  Future<List<MUnitPhrase>> getDataByLangPhrase(
      int langid, String phrase, List<MTextbook> lstTextbooks) async {
    final lst = MUnitPhrases.fromJson(await getDataByUrl(
            "VUNITPHRASES?filter=LANGID,eq,$langid&filter=PHRASE,eq,${Uri.encodeComponent(phrase)}"))
        .lst
        .where((o) => o.phrase == phrase)
        .toList();
    return _setTextbook(lst, lstTextbooks);
  }

  Future<int> create(MUnitPhrase item) async =>
      (await callSPByUrl("UNITPHRASES_CREATE", json.encode(item))).newid;

  Future updateSeqNum(int id, int seqnum) async =>
      print(await updateByUrl("UNITPHRASES/$id", "SEQNUM=$seqnum"));

  Future updateTranslation(int id, String translation) async =>
      print(await updateByUrl("UNITPHRASES/$id", "TRANSLATION=$translation"));

  Future update(MUnitPhrase item) async =>
      print(await callSPByUrl("UNITPHRASES_UPDATE", json.encode(item)));

  Future delete(MUnitPhrase item) async =>
      print(await callSPByUrl("UNITPHRASES_DELETE", json.encode(item)));
}
