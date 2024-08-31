import 'package:lolly_flutter/models/misc/mwebtextbook.dart';

import '../misc/base_service.dart';

class WebTextbookService extends BaseService<MWebTextbook> {
  Future<List<MWebTextbook>> getDataByLang(int langid) async =>
      MWebTextbooks.fromJson(
              await getDataByUrl("VWEBTEXTBOOKS?filter=LANGID,eq,$langid"))
          .lst;
}
