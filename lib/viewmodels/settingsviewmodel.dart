import 'package:lolly_flutter/models/misc/mcommon.dart';
import 'package:lolly_flutter/models/misc/mdictionary.dart';
import 'package:lolly_flutter/models/misc/mlanguage.dart';
import 'package:lolly_flutter/models/misc/mtextbook.dart';
import 'package:lolly_flutter/models/misc/musersetting.dart';
import 'package:lolly_flutter/models/misc/musmapping.dart';
import 'package:lolly_flutter/models/misc/mvoice.dart';
import 'package:lolly_flutter/services/misc/languageservice.dart';
import 'package:lolly_flutter/services/misc/usersettingservice.dart';
import 'package:lolly_flutter/services/misc/usmappingservice.dart';

class SettingsViewModel {
  List<MUSMapping> lstUSMappings;
  List<MUserSetting> lstUserSettings;

  String getUSValue(MUserSettingInfo info) {
    final o = lstUserSettings.firstWhere((o2) => o2.id == info.usersettingid);
    switch (info.valueid) {
      case 1:
        return o.value1;
      case 2:
        return o.value2;
      case 3:
        return o.value3;
      case 4:
        return o.value4;
      default:
        return null;
    }
  }

  void setUSValue(MUserSettingInfo info, String value) {
    final o = lstUserSettings.firstWhere((o2) => o2.id == info.usersettingid);
    switch (info.valueid) {
      case 1:
        o.value1 = value;
        break;
      case 2:
        o.value2 = value;
        break;
      case 3:
        o.value3 = value;
        break;
      case 4:
        o.value4 = value;
        break;
    }
  }

  MUserSettingInfo INFO_USLANGID;
  int get uslangid => int.parse(getUSValue(INFO_USLANGID));
  set uslangid(int value) => setUSValue(INFO_USLANGID, value.toString());
  MUserSettingInfo INFO_USTEXTBOOKID;
  int get ustextbookid => int.parse(getUSValue(INFO_USTEXTBOOKID));
  set ustextbookid(int value) =>
      setUSValue(INFO_USTEXTBOOKID, value.toString());
  MUserSettingInfo INFO_USDICTREFERENCE;
  String get usdictreference => getUSValue(INFO_USDICTREFERENCE);
  set usdictreference(String value) => setUSValue(INFO_USDICTREFERENCE, value);
  MUserSettingInfo INFO_USDICTNOTE;
  int get usdictnoteid => int.parse(getUSValue(INFO_USDICTNOTE));
  set usdictnoteid(int value) => setUSValue(INFO_USDICTNOTE, value.toString());
  MUserSettingInfo INFO_USDICTTRANSLATION;
  int get usdicttranslationid => int.parse(getUSValue(INFO_USDICTTRANSLATION));
  set usdicttranslationid(int value) =>
      setUSValue(INFO_USDICTTRANSLATION, value.toString());
  MUserSettingInfo INFO_USUNITFROM;
  int get usunitfrom => int.parse(getUSValue(INFO_USUNITFROM));
  set usunitfrom(int value) => setUSValue(INFO_USUNITFROM, value.toString());
  MUserSettingInfo INFO_USPARTFROM;
  int get uspartfrom => int.parse(getUSValue(INFO_USPARTFROM));
  set uspartfrom(int value) => setUSValue(INFO_USPARTFROM, value.toString());
  MUserSettingInfo INFO_USUNITTO;
  int get usunitto => int.parse(getUSValue(INFO_USUNITTO));
  set usunitto(int value) => setUSValue(INFO_USUNITTO, value.toString());
  MUserSettingInfo INFO_USPARTTO;
  int get uspartto => int.parse(getUSValue(INFO_USPARTTO));
  set uspartto(int value) => setUSValue(INFO_USPARTTO, value.toString());

  List<MLanguage> lstLanguages;
  MLanguage selectedLang;
  List<MVoice> lstVoices;
  MVoice selectedVoice;
  List<MTextbook> lstTextbooks;
  MTextbook selectedTextbook;
  List<MDictionary> lstDictsReference;
  MDictionary selectedDictReference;
  List<MDictionary> lstDictsNote;
  MDictionary selectedDictNote;
  List<MDictionary> lstDictsTranslation;
  MDictionary selectedDictTranslation;

  final languageService = LanguageService();
  final usMappingService = USMappingService();
  final userSettingService = UserSettingService();

  MUserSettingInfo _getUSInfo(String name) {
    var o = lstUSMappings.firstWhere((v) => v.name == name);
    var entityid = o.entityid != -1
        ? o.entityid
        : o.level == 1
            ? selectedLang.id
            : o.level == 2 ? selectedTextbook.id : 0;
    var o2 = lstUserSettings
        .firstWhere((v) => v.kind == o.kind && v.entityid == entityid);
    return MUserSettingInfo(o2.id, o.valueid);
  }

  Future getData() async {
    lstLanguages = await languageService.getData();
    lstUSMappings = await usMappingService.getData();
    lstUserSettings =
        await userSettingService.getDataByUser(GlobalConstants.userid);
    INFO_USLANGID = _getUSInfo(MUSMapping.NAME_USLANGID);
    selectedLang = lstLanguages.firstWhere((o) => o.id == uslangid);
  }
}
