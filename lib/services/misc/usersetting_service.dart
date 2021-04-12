import 'package:lolly_flutter/models/misc/mcommon.dart';
import 'package:lolly_flutter/models/misc/musersetting.dart';

import '../misc/base_service.dart';

class UserSettingService extends BaseService<MUserSetting> {
  Future<List<MUserSetting>> getDataByUser() async => MUserSettings.fromJson(
          await getDataByUrl("USERSETTINGS?filter=USERID,eq,${Global.userid}"))
      .lst;

  Future updateByInt(MUserSettingInfo info, int v) async =>
      updateByString(info, v.toString());

  Future updateByString(MUserSettingInfo info, String v) async =>
      print(await updateByUrlString(
          "USERSETTINGS/${info.usersettingid}", "VALUE${info.valueid}=$v"));
}
