import 'package:lolly_flutter/models/misc/mlanguage.dart';

import '../misc/baseservice.dart';

class LanguageService extends BaseService {
  Future<List<MLanguage>> getData() async =>
      MLanguages.fromJson(await getDataByUrl("LANGUAGES?filter=ID,neq,0")).lst;
}
