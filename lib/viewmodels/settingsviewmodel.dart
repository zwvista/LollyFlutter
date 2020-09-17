import 'package:lolly_flutter/models/misc/mautocorrect.dart';
import 'package:lolly_flutter/models/misc/mcommon.dart';
import 'package:lolly_flutter/models/misc/mdictionary.dart';
import 'package:lolly_flutter/models/misc/mlanguage.dart';
import 'package:lolly_flutter/models/misc/mtextbook.dart';
import 'package:lolly_flutter/models/misc/musersetting.dart';
import 'package:lolly_flutter/models/misc/musmapping.dart';
import 'package:lolly_flutter/models/misc/mvoice.dart';
import 'package:lolly_flutter/services/misc/autocorrectservice.dart';
import 'package:lolly_flutter/services/misc/dictionaryservice.dart';
import 'package:lolly_flutter/services/misc/languageservice.dart';
import 'package:lolly_flutter/services/misc/textbookservice.dart';
import 'package:lolly_flutter/services/misc/usersettingservice.dart';
import 'package:lolly_flutter/services/misc/usmappingservice.dart';
import 'package:lolly_flutter/services/misc/voiceservice.dart';

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
  MUserSettingInfo INFO_USVOICEID;
  int get usvoiceid => int.parse(getUSValue(INFO_USLANGID));
  set usvoiceid(int value) => setUSValue(INFO_USLANGID, value.toString());
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
  List<MAutoCorrect> lstAutoCorrect;

  final _languageService = LanguageService();
  final _usMappingService = USMappingService();
  final _userSettingService = UserSettingService();
  final _dictionaryService = DictionaryService();
  final _textbookService = TextbookService();
  final _autoCorrectService = AutoCorrectService();
  final _voiceService = VoiceService();

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
    lstLanguages = await _languageService.getData();
    lstUSMappings = await _usMappingService.getData();
    lstUserSettings =
        await _userSettingService.getDataByUser(GlobalConstants.userid);
    INFO_USLANGID = _getUSInfo(MUSMapping.NAME_USLANGID);
    selectedLang = lstLanguages.firstWhere((o) => o.id == uslangid);
  }

  Future setSelectedLang(MLanguage v) async {
    final isinit = uslangid == v.id;
    uslangid = v.id;
    INFO_USTEXTBOOKID = _getUSInfo(MUSMapping.NAME_USTEXTBOOKID);
    INFO_USDICTREFERENCE = _getUSInfo(MUSMapping.NAME_USDICTREFERENCE);
    INFO_USDICTNOTE = _getUSInfo(MUSMapping.NAME_USDICTNOTE);
    INFO_USDICTTRANSLATION = _getUSInfo(MUSMapping.NAME_USDICTTRANSLATION);
    INFO_USVOICEID = _getUSInfo(MUSMapping.NAME_USWINDOWSVOICEID);
    lstDictsReference =
        await _dictionaryService.getDictsReferenceByLang(uslangid);
    lstDictsNote = await _dictionaryService.getDictsNoteByLang(uslangid);
    lstDictsTranslation =
        await _dictionaryService.getDictsTranslationByLang(uslangid);
    lstTextbooks = await _textbookService.getDataByLang(uslangid);
    lstAutoCorrect = await _autoCorrectService.getDataByLang(uslangid);
    lstVoices = await _voiceService.getDataByLang(uslangid);
    selectedDictReference = lstDictsReference
        .firstWhere((o) => o.dictid.toString() == usdictreference);
    selectedDictNote = lstDictsNote.firstWhere((o) => o.dictid == usdictnoteid);
    selectedDictTranslation =
        lstDictsTranslation.firstWhere((o) => o.dictid == usdicttranslationid);
    selectedTextbook = lstTextbooks.firstWhere((o) => o.id == ustextbookid);
    selectedVoice = lstVoices.firstWhere((o) => o.id == usvoiceid);
    if (!isinit) _userSettingService.updateByInt(INFO_USLANGID, uslangid);
  }
}
