import 'package:lolly_flutter/models/misc/mautocorrect.dart';

import '../misc/baseservice.dart';

class AutoCorrectService extends BaseService {
  Future<List<MAutoCorrect>> GetDataByLang(int langid) async =>
      MAutoCorrects.fromJson(
              await getDataByUrl("AUTOCORRECT?filter=LANGID,eq,$langid"))
          .lst;
  String autoCorrect(String text, List<MAutoCorrect> lstAutoCorrect,
          String colFunc1(MAutoCorrect), String colFunc2(MAutoCorrect)) =>
      lstAutoCorrect.fold(
          text, (str, row) => str.replaceAll(colFunc1(row), colFunc2(row)));
}
