import 'package:lolly_flutter/models/misc/musersetting.dart';
import 'package:lolly_flutter/models/misc/mvoice.dart';

import '../misc/baseservice.dart';

class UserSettingService extends BaseService {
  Future<List<MVoice>> getDataByUser(int userid) async => MVoices.fromJson(
          await getDataByUrl("USERSETTINGS?filter=USERID,eq,${userid}"))
      .lst;

  Future updateByInt(MUserSettingInfo info, int v) async =>
      updateByString(info, v.toString());

  Future updateByString(MUserSettingInfo info, String v) async =>
      print(await updateByUrl(
          "USERSETTINGS/${info.usersettingid}", "VALUE${info.valueid}=${v}"));
}
