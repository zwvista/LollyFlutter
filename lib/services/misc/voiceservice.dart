import 'package:lolly_flutter/models/misc/mvoice.dart';

import '../misc/baseservice.dart';

class VoiceService extends BaseService {
  Future<List<MVoice>> getDataByLang(int langid) async =>
      MVoices.fromJson(await getDataByUrl("VVOICES?filter=LANGID,eq,$langid"))
          .lst;
}
