import 'package:lolly_flutter/models/wpp/mwordfami.dart';
import 'package:lolly_flutter/services/misc/base_service.dart';

class WordFamiService extends BaseService<MWordFami> {
  Future<List<MWordFami>> getDataByUserWord(int userid, int wordid) async =>
      MWordsFami.fromJson(await getDataByUrl(
              "WORDSFAMI?filter=USERID,eq,$userid&filter=WORDID,eq,$wordid"))
          .lst;

  Future<int> _create(MWordFami item) async =>
      await createByUrl("WORDSFAMI", item);

  Future _updateItem(MWordFami item) async =>
      print(await updateByUrl("WORDSFAMI/${item.id}", item));

  Future delete(int id) async => print(await deleteByUrl("WORDSFAMI/$id"));

  Future<MWordFami> update(int wordid, bool isCorrect) async {
    var lst = await getDataByUserWord(userid, wordid);
    var item = MWordFami()
      ..userid = userid
      ..wordid = wordid;
    if (lst.isEmpty) {
      item.correct = isCorrect ? 1 : 0;
      item.total = 1;
      await _create(item);
    } else {
      var o = lst[0];
      item.id = o.id;
      item.correct = o.correct + (isCorrect ? 1 : 0);
      item.total = o.total + 1;
      await _updateItem(item);
    }
    return item;
  }
}
