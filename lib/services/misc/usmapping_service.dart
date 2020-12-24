import 'package:lolly_flutter/models/misc/musmapping.dart';

import '../misc/base_service.dart';

class USMappingService extends BaseService<MUSMapping> {
  Future<List<MUSMapping>> getData() async =>
      MUSMappings.fromJson(await getDataByUrl("USMAPPINGS")).lst;
}
