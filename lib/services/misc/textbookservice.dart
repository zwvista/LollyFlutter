import 'package:lolly_flutter/models/misc/mcommon.dart';
import 'package:lolly_flutter/models/misc/mtextbook.dart';

import '../misc/baseservice.dart';

class TextbookService extends BaseService {
  Future<List<MTextbook>> getDataByLang(int langid) async {
    final lst = MTextbooks.fromJson(
            await getDataByUrl("TEXTBOOKS?filter=LANGID,eq,${langid}"))
        .lst;
    List<String> f(String units) {
      var m = RegExp(r"UNITS,(\d+)").firstMatch(units);
      if (m != null) {
        final n = int.parse(m.group(1));
        return [for (var i = 1; i <= n; i++) i.toString()];
      }
      m = RegExp(r"PAGES,(\d+),(\d+)").firstMatch(units);
      if (m != null) {
        final n1 = int.parse(m.group(1));
        final n2 = int.parse(m.group(2));
        final n = (n1 + n2 - 1) / n2;
        return [for (var i = 1; i <= n; i++) "${i * n2 - n2 + 1}~${i * n2}"];
      }
      m = RegExp(r"CUSTOM,(.+)").firstMatch(units);
      if (m != null) return m.group(1).split(',');
      return new List<String>();
    }

    lst.forEach((o) {
      o.lstUnits = f(o.units)
          .asMap()
          .map((i, s) => MapEntry(i, MSelectItem(i + 1, s)))
          .values;
      o.lstParts = o.parts
          .split(',')
          .asMap()
          .map((i, s) => MapEntry(i, MSelectItem(i + 1, s)))
          .values;
    });
    return lst;
  }

  Future<int> create(MTextbook item) async =>
      await createByUrl("TEXTBOOKS", item.toJson());
  Future update(MTextbook item) async =>
      print(await updateByUrl("TEXTBOOKS/${item.id}", item.toJson()));
  Future delete(int id) async => print(await deleteByUrl("TEXTBOOKS/${id}"));
}
