import 'package:lolly_flutter/models/misc/mautocorrect.dart';

import '../misc/base_service.dart';

class AutoCorrectService extends BaseService<MAutoCorrect> {
  Future<List<MAutoCorrect>> getDataByLang(int langid) async =>
      MAutoCorrects.fromJson(
              await getDataByUrl("AUTOCORRECT?filter=LANGID,eq,$langid"))
          .lst;
  String autoCorrect(
          String text,
          List<MAutoCorrect> lstAutoCorrect,
          String Function(MAutoCorrect) colFunc1,
          String Function(MAutoCorrect) colFunc2) =>
      lstAutoCorrect.fold(
          text, (str, row) => str.replaceAll(colFunc1(row), colFunc2(row)));
}
