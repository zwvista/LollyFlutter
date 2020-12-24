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
  Future update(MDictionary item) async =>
      print(await updateByUrl("DICTIONARIES/${item.id}", item));
  Future delete(int id) async => print(await deleteByUrl("DICTIONARIES/$id"));
}
