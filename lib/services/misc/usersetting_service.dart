import 'package:flutter/cupertino.dart';
import 'package:lolly_flutter/models/misc/mcommon.dart';
import 'package:lolly_flutter/models/misc/musersetting.dart';

import '../misc/base_service.dart';

class UserSettingService extends BaseService<MUserSetting> {
  Future<List<MUserSetting>> getData() async => MUserSettings.fromJson(
          await getDataByUrl("USERSETTINGS?filter=USERID,eq,${Global.userid}"))
      .lst;

  Future<void> updateByInt(MUserSettingInfo info, int v) async =>
      updateByString(info, v.toString());

  Future<void> updateByString(MUserSettingInfo info, String v) async =>
      debugPrint((await updateByUrlString(
              "USERSETTINGS/${info.usersettingid}", "VALUE${info.valueid}=$v"))
          .toString());
}
