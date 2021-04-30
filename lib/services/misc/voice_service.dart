import 'package:lolly_flutter/models/misc/mvoice.dart';

import '../misc/base_service.dart';

class VoiceService extends BaseService<MVoice> {
  Future<List<MVoice>> getDataByLang(int langid) async =>
      MVoices.fromJson(await getDataByUrl("VVOICES?filter=LANGID,eq,$langid"))
          .lst
          .where((o) => o.voicetypeid == 6)
          .toList();
}
