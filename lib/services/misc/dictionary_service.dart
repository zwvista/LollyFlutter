import 'package:flutter/cupertino.dart';
import 'package:lolly_flutter/models/misc/mdictionary.dart';

import '../misc/base_service.dart';

class DictionaryService extends BaseService<MDictionary> {
  Future<List<MDictionary>> getDictsByLang(int langid) async =>
      MDictionaries.fromJson(await getDataByUrl(
              "VDICTIONARIES?filter=LANGIDFROM,eq,$langid&order=SEQNUM&order=DICTNAME"))
          .lst;
  Future<List<MDictionary>> getDictsReferenceByLang(int langid) async =>
      MDictionaries.fromJson(await getDataByUrl(
              "VDICTSREFERENCE?filter=LANGIDFROM,eq,$langid&order=SEQNUM&order=DICTNAME"))
          .lst;
  Future<List<MDictionary>> getDictsNoteByLang(int langid) async =>
      MDictionaries.fromJson(
              await getDataByUrl("VDICTSNOTE?filter=LANGIDFROM,eq,$langid"))
          .lst;
  Future<List<MDictionary>> getDictsTranslationByLang(int langid) async =>
      MDictionaries.fromJson(await getDataByUrl(
              "VDICTSTRANSLATION?filter=LANGIDFROM,eq,$langid"))
          .lst;
  Future<int> create(MDictionary item) async =>
      await createByUrl("DICTIONARIES", item);
  Future<void> update(MDictionary item) async => debugPrint(
      (await updateByUrl("DICTIONARIES/${item.id}", item)).toString());
  Future<void> delete(int id) async =>
      debugPrint((await deleteByUrl("DICTIONARIES/$id")).toString());
}
