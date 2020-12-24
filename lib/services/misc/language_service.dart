import 'package:lolly_flutter/models/misc/mlanguage.dart';

import '../misc/base_service.dart';

class LanguageService extends BaseService<MLanguage> {
  Future<List<MLanguage>> getData() async =>
      MLanguages.fromJson(await getDataByUrl("LANGUAGES?filter=ID,neq,0")).lst;
}
