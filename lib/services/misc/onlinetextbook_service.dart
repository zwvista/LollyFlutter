import 'package:lolly_flutter/models/misc/monlinetextbook.dart';

import '../misc/base_service.dart';

class OnlineTextbookService extends BaseService<MOnlineTextbook> {
  Future<List<MOnlineTextbook>> getDataByLang(int langid) async =>
      MOnlineTextbooks.fromJson(
              await getDataByUrl("VONLINETEXTBOOKS?filter=LANGID,eq,$langid"))
          .lst;
}
