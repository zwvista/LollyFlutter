import 'package:flutter/cupertino.dart';
import 'package:lolly_flutter/models/misc/mtextbook.dart';
import 'package:lolly_flutter/models/wpp/munitword.dart';

import '../misc/base_service.dart';

class UnitWordService extends BaseService<MUnitWord> {
  Future<List<MUnitWord>> getDataByTextbookUnitPart(
      MTextbook textbook, int unitPartFrom, int unitPartTo) async {
    final lst = MUnitWords.fromJson(await getDataByUrl(
            "VUNITWORDS?filter=TEXTBOOKID,eq,${textbook.id}&filter=UNITPART,bt,$unitPartFrom,$unitPartTo&order=UNITPART&order=SEQNUM"))
        .lst;
    for (var o in lst) {
      o.textbook = textbook;
    }
    return lst;
  }

  Future<List<MUnitWord>> getDataByTextbook(MTextbook textbook) async {
    final lst = MUnitWords.fromJson(await getDataByUrl(
            "VUNITWORDS?filter=TEXTBOOKID,eq,${textbook.id}&order=WORDID"))
        .lst;
    for (var o in lst) {
      o.textbook = textbook;
    }
    return lst;
  }

  List<MUnitWord> _setTextbook(
      List<MUnitWord> lst, List<MTextbook> lstTextbooks) {
    for (var o in lst) {
      o.textbook = lstTextbooks.firstWhere((o3) => o3.id == o.textbookid);
    }
    return lst;
  }

  Future<List<MUnitWord>> getDataByLang(
      int langid, List<MTextbook> lstTextbooks) async {
    final lst = MUnitWords.fromJson(await getDataByUrl(
            "VUNITWORDS?filter=LANGID,eq,$langid&order=TEXTBOOKID&order=UNIT&order=PART&order=SEQNUM"))
        .lst;
    return _setTextbook(lst, lstTextbooks);
  }

  Future<MUnitWord?> getDataById(int id, List<MTextbook> lstTextbooks) async {
    var lst =
        MUnitWords.fromJson(await getDataByUrl("VUNITWORDS?filter=ID,eq,$id"))
            .lst;
    lst = _setTextbook(lst, lstTextbooks);
    return lst.isNotEmpty ? lst[0] : null;
  }

  Future<List<MUnitWord>> getDataByLangWord(
      int langid, String word, List<MTextbook> lstTextbooks) async {
    final lst = MUnitWords.fromJson(await getDataByUrl(
            "VUNITWORDS?filter=LANGID,eq,$langid&filter=WORD,eq,${Uri.encodeComponent(word)}"))
        .lst
        .where((o) => o.word == word)
        .toList();
    return _setTextbook(lst, lstTextbooks);
  }

  Future<int> create(MUnitWord item) async =>
      (await callSPByUrl("UNITWORDS_CREATE", item)).newid;

  Future updateSeqNum(int id, int seqnum) async => debugPrint(
      (await updateByUrlString("UNITWORDS/$id", "SEQNUM=$seqnum")).toString());

  Future updateNote(int id, String note) async => debugPrint(
      (await updateByUrlString("UNITWORDS/$id", "NOTE=$note")).toString());

  Future update(MUnitWord item) async =>
      debugPrint((await callSPByUrl("UNITWORDS_UPDATE", item)).toString());

  Future delete(MUnitWord item) async =>
      debugPrint((await callSPByUrl("UNITWORDS_DELETE", item)).toString());
}
