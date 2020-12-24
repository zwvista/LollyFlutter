import 'package:lolly_flutter/models/misc/mcommon.dart';

import '../misc/base_service.dart';

class CodeService extends BaseService<MCode> {
  Future<List<MCode>> getDictCodes() async =>
      MCodes.fromJson(await getDataByUrl("CODES?filter=KIND,eq,1")).lst;
  Future<List<MCode>> getReadNumberCodes() async =>
      MCodes.fromJson(await getDataByUrl("CODES?filter=KIND,eq,3")).lst;
}
