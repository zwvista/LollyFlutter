import 'package:flutter/cupertino.dart';
import 'package:lolly_flutter/models/misc/mautocorrect.dart';
import 'package:lolly_flutter/models/misc/mcommon.dart';
import 'package:lolly_flutter/models/misc/mdictionary.dart';
import 'package:lolly_flutter/models/misc/mlanguage.dart';
import 'package:lolly_flutter/models/misc/mtextbook.dart';
import 'package:lolly_flutter/models/misc/musersetting.dart';
import 'package:lolly_flutter/models/misc/musmapping.dart';
import 'package:lolly_flutter/models/misc/mvoice.dart';
import 'package:lolly_flutter/services/misc/autocorrect_service.dart';
import 'package:lolly_flutter/services/misc/dictionary_service.dart';
import 'package:lolly_flutter/services/misc/language_service.dart';
import 'package:lolly_flutter/services/misc/textbook_service.dart';
import 'package:lolly_flutter/services/misc/usersetting_service.dart';
import 'package:lolly_flutter/services/misc/usmapping_service.dart';
import 'package:lolly_flutter/services/misc/voice_service.dart';

class SettingsViewModel with ChangeNotifier {
  List<MUSMapping> lstUSMappings = [];
  List<MUserSetting> lstUserSettings = [];

  String getUSValue(MUserSettingInfo info) {
    final o = lstUserSettings.firstWhere((o2) => o2.id == info?.usersettingid,
        orElse: () => null);
    switch (info?.valueid) {
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
    final o = lstUserSettings.firstWhere((o2) => o2.id == info?.usersettingid,
        orElse: () => null);
    switch (info?.valueid) {
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

  MUserSettingInfo INFO_USLANG;
  int get uslang => int.parse(getUSValue(INFO_USLANG));
  set uslang(int value) => setUSValue(INFO_USLANG, value.toString());
  MUserSettingInfo INFO_USVOICE;
  int get usvoice => int.parse(getUSValue(INFO_USVOICE));
  set usvoice(int value) => setUSValue(INFO_USVOICE, value.toString());
  MUserSettingInfo INFO_USTEXTBOOK;
  int get ustextbook => int.parse(getUSValue(INFO_USTEXTBOOK));
  set ustextbook(int value) => setUSValue(INFO_USTEXTBOOK, value.toString());
  MUserSettingInfo INFO_USDICTREFERENCE;
  String get usdictreference => getUSValue(INFO_USDICTREFERENCE);
  set usdictreference(String value) => setUSValue(INFO_USDICTREFERENCE, value);
  MUserSettingInfo INFO_USDICTNOTE;
  int get usdictnote => int.parse(getUSValue(INFO_USDICTNOTE));
  set usdictnote(int value) => setUSValue(INFO_USDICTNOTE, value.toString());
  MUserSettingInfo INFO_USDICTTRANSLATION;
  int get usdicttranslation => int.parse(getUSValue(INFO_USDICTTRANSLATION));
  set usdicttranslation(int value) =>
      setUSValue(INFO_USDICTTRANSLATION, value.toString());
  MUserSettingInfo INFO_USUNITFROM;
  int get usunitfrom => int.parse(getUSValue(INFO_USUNITFROM) ?? "0");
  String get usunitfromstr => selectedTextbook?.unitstr(usunitfrom) ?? "";
  set usunitfrom(int value) => setUSValue(INFO_USUNITFROM, value.toString());
  MUserSettingInfo INFO_USPARTFROM;
  int get uspartfrom => int.parse(getUSValue(INFO_USPARTFROM) ?? "0");
  String get uspartfromstr => selectedTextbook?.partstr(uspartfrom) ?? "";
  set uspartfrom(int value) => setUSValue(INFO_USPARTFROM, value.toString());
  MUserSettingInfo INFO_USUNITTO;
  int get usunitto => int.parse(getUSValue(INFO_USUNITTO) ?? "0");
  String get usunittostr => selectedTextbook?.unitstr(usunitto) ?? "";
  set usunitto(int value) => setUSValue(INFO_USUNITTO, value.toString());
  MUserSettingInfo INFO_USPARTTO;
  int get uspartto => int.parse(getUSValue(INFO_USPARTTO) ?? "0");
  String get usparttostr => selectedTextbook?.partstr(uspartto) ?? "";
  set uspartto(int value) => setUSValue(INFO_USPARTTO, value.toString());
  int get usunitpartfrom => usunitfrom * 10 + uspartfrom;
  int get usunitpartto => usunitto * 10 + uspartto;
  bool get isSingleUnitPart => usunitpartfrom == usunitpartto;
  bool get isInvaidUnitPart => usunitpartfrom > usunitpartto;

  List<MLanguage> lstLanguages = [];
  MLanguage _selectedLang;
  MLanguage get selectedLang => _selectedLang;
  List<MVoice> lstVoices = [];
  MVoice _selectedVoice;
  MVoice get selectedVoice => _selectedVoice;
  List<MTextbook> lstTextbooks = [];
  List<MSelectItem> lstTextbookFilters = [];
  MTextbook _selectedTextbook;
  MTextbook get selectedTextbook => _selectedTextbook;
  List<MDictionary> lstDictsReference = [];
  MDictionary _selectedDictReference;
  MDictionary get selectedDictReference => _selectedDictReference;
  List<MDictionary> lstDictsNote = [];
  MDictionary _selectedDictNote;
  MDictionary get selectedDictNote => _selectedDictNote;
  List<MDictionary> lstDictsTranslation = [];
  MDictionary _selectedDictTranslation;
  MDictionary get selectedDictTranslation => _selectedDictTranslation;
  List<MAutoCorrect> lstAutoCorrect = [];

  final _languageService = LanguageService();
  final _usMappingService = USMappingService();
  final _userSettingService = UserSettingService();
  final _dictionaryService = DictionaryService();
  final _textbookService = TextbookService();
  final _autoCorrectService = AutoCorrectService();
  final _voiceService = VoiceService();

  List<MSelectItem> get lstUnits => selectedTextbook?.lstUnits;
  List<MSelectItem> get lstParts => selectedTextbook?.lstParts;
  int get unitCount => lstUnits?.length ?? 0;
  int get partCount => lstParts?.length ?? 0;
  bool get isSingleUnit =>
      usunitfrom == usunitto && uspartfrom == 1 && uspartto == partCount;
  bool get isSinglePart => partCount == 1;
  static final List<MSelectItem> lstToTypes = [
    MSelectItem(0, "Unit"),
    MSelectItem(1, "Part"),
    MSelectItem(2, "To")
  ];
  UnitPartToType toType = UnitPartToType.To;
  bool unitToIsEnabled = true;
  bool partToIsEnabled = true;
  bool previousIsEnabled = true;
  bool nextIsEnabled = true;
  String previousText = "Previous";
  String nextText = "Next";
  bool partFromIsEnabled = true;

  static final scopeWordFilters = ["Word", "Note"];
  static final scopePhraseFilters = ["Phrase", "Translation"];

  MUserSettingInfo _getUSInfo(String name) {
    var o = lstUSMappings.firstWhere((v) => v.name == name);
    var entityid = o.entityid != -1
        ? o.entityid
        : o.level == 1
            ? selectedLang.id
            : o.level == 2
                ? selectedTextbook.id
                : 0;
    var o2 = lstUserSettings
        .firstWhere((v) => v.kind == o.kind && v.entityid == entityid);
    return MUserSettingInfo(o2.id, o.valueid);
  }

  Future getData() async {
    lstLanguages = await _languageService.getData();
    lstUSMappings = await _usMappingService.getData();
    lstUserSettings =
        await _userSettingService.getDataByUser(GlobalConstants.userid);
    INFO_USLANG = _getUSInfo(MUSMapping.NAME_USLANG);
    await setSelectedLang(lstLanguages.firstWhere((o) => o.id == uslang));
  }

  Future setSelectedLang(MLanguage v) async {
    _selectedLang = v;
    final isinit = uslang == v.id;
    uslang = v.id;
    INFO_USTEXTBOOK = _getUSInfo(MUSMapping.NAME_USTEXTBOOK);
    INFO_USDICTREFERENCE = _getUSInfo(MUSMapping.NAME_USDICTREFERENCE);
    INFO_USDICTNOTE = _getUSInfo(MUSMapping.NAME_USDICTNOTE);
    INFO_USDICTTRANSLATION = _getUSInfo(MUSMapping.NAME_USDICTTRANSLATION);
    INFO_USVOICE = _getUSInfo(MUSMapping.NAME_USWINDOWSVOICE);
    _selectedDictReference = null;
    lstDictsReference =
        await _dictionaryService.getDictsReferenceByLang(uslang);
    _selectedDictNote = null;
    lstDictsNote = await _dictionaryService.getDictsNoteByLang(uslang);
    _selectedDictTranslation = null;
    lstDictsTranslation =
        await _dictionaryService.getDictsTranslationByLang(uslang);
    _selectedTextbook = null;
    lstTextbooks = await _textbookService.getDataByLang(uslang);
    lstTextbookFilters =
        lstTextbooks.map((o) => MSelectItem(o.id, o.textbookname)).toList();
    lstTextbookFilters.insert(0, MSelectItem(0, "All Textbooks"));
    lstAutoCorrect = await _autoCorrectService.getDataByLang(uslang);
    _selectedVoice = null;
    lstVoices = await _voiceService.getDataByLang(uslang);
    await setSelectedDictReference(lstDictsReference
        .firstWhere((o) => o.dictid.toString() == usdictreference));
    await setSelectedDictNote(
        lstDictsNote.firstWhere((o) => o.dictid == usdictnote));
    await setSelectedDictTranslation(
        lstDictsTranslation.firstWhere((o) => o.dictid == usdicttranslation));
    await setSelectedTextbook(
        lstTextbooks.firstWhere((o) => o.id == ustextbook));
    await setSelectedVoice(lstVoices.first);
    if (!isinit) await _userSettingService.updateByInt(INFO_USLANG, uslang);
  }

  Future setSelectedVoice(MVoice v) async {
    _selectedVoice = v;
    usvoice = v.id;
    await _userSettingService.updateByInt(INFO_USVOICE, usvoice);
    notifyListeners();
  }

  Future setSelectedDictReference(MDictionary v) async {
    _selectedDictReference = v;
    usdictreference = v.dictid.toString();
    await _userSettingService.updateByString(
        INFO_USDICTREFERENCE, usdictreference);
    notifyListeners();
  }

  Future setSelectedDictNote(MDictionary v) async {
    _selectedDictNote = v;
    usdictnote = v.dictid;
    await _userSettingService.updateByInt(INFO_USDICTNOTE, usdictnote);
    notifyListeners();
  }

  Future setSelectedDictTranslation(MDictionary v) async {
    _selectedDictTranslation = v;
    usdicttranslation = v.dictid;
    await _userSettingService.updateByInt(
        INFO_USDICTTRANSLATION, usdicttranslation);
    notifyListeners();
  }

  Future setSelectedTextbook(MTextbook v) async {
    _selectedTextbook = v;
    ustextbook = v.id;
    INFO_USUNITFROM = _getUSInfo(MUSMapping.NAME_USUNITFROM);
    INFO_USPARTFROM = _getUSInfo(MUSMapping.NAME_USPARTFROM);
    INFO_USUNITTO = _getUSInfo(MUSMapping.NAME_USUNITTO);
    INFO_USPARTTO = _getUSInfo(MUSMapping.NAME_USPARTTO);
    setToType(isSingleUnit
        ? UnitPartToType.Unit
        : isSingleUnitPart
            ? UnitPartToType.Part
            : UnitPartToType.To);
    await _userSettingService.updateByInt(INFO_USTEXTBOOK, ustextbook);
    notifyListeners();
  }

  Future setToType(UnitPartToType v) async {
    toType = v;
    final b = v == UnitPartToType.To;
    unitToIsEnabled = b;
    partToIsEnabled = b && !isSinglePart;
    previousIsEnabled = !b;
    nextIsEnabled = !b;
    final b2 = v != UnitPartToType.Unit;
    final t = !b2 ? "Unit" : "Part";
    previousText = "Previous " + t;
    nextText = "Next " + t;
    partFromIsEnabled = b2 && !isSinglePart;
    if (v == UnitPartToType.Unit)
      await _doUpdateSingleUnit();
    else if (v == UnitPartToType.Part) await _doUpdateUnitPartTo();
    notifyListeners();
  }

  Future updateUnitFrom(int v) async {
    await _doUpdateUnitFrom(v, check: false);
    if (toType == UnitPartToType.Unit)
      await _doUpdateSingleUnit();
    else if (toType == UnitPartToType.Part || isInvaidUnitPart)
      await _doUpdateUnitPartTo();
    notifyListeners();
  }

  Future updatePartFrom(int v) async {
    await _doUpdatePartFrom(v, check: false);
    if (toType == UnitPartToType.Part || isInvaidUnitPart)
      await _doUpdateUnitPartTo();
    notifyListeners();
  }

  Future updateUnitTo(int v) async {
    await _doUpdateUnitTo(v, check: false);
    if (isInvaidUnitPart) await _doUpdateUnitPartFrom();
    notifyListeners();
  }

  Future updatePartTo(int v) async {
    await _doUpdatePartTo(v, check: false);
    if (isInvaidUnitPart) await _doUpdateUnitPartFrom();
    notifyListeners();
  }

  Future previousUnitPart() async {
    if (toType == UnitPartToType.Unit) {
      if (usunitfrom > 1) {
        await _doUpdateUnitFrom(usunitfrom - 1);
        await _doUpdateUnitTo(usunitfrom);
      }
    } else if (uspartfrom > 1) {
      await _doUpdatePartFrom(uspartfrom - 1);
      await _doUpdateUnitPartTo();
    } else if (usunitfrom > 1) {
      await _doUpdateUnitFrom(usunitfrom - 1);
      await _doUpdatePartFrom(partCount);
      await _doUpdateUnitPartTo();
    }
  }

  Future nextUnitPart() async {
    if (toType == UnitPartToType.Unit) {
      if (usunitfrom < unitCount) {
        await _doUpdateUnitFrom(usunitfrom + 1);
        await _doUpdateUnitTo(usunitfrom);
      }
    } else if (uspartfrom > 1) {
      await _doUpdatePartFrom(uspartfrom + 1);
      await _doUpdateUnitPartTo();
    } else if (usunitfrom > 1) {
      await _doUpdateUnitFrom(usunitfrom + 1);
      await _doUpdatePartFrom(1);
      await _doUpdateUnitPartTo();
    }
  }

  Future _doUpdateUnitPartFrom() async {
    await _doUpdateUnitFrom(usunitto);
    await _doUpdatePartFrom(uspartto);
  }

  Future _doUpdateUnitPartTo() async {
    await _doUpdateUnitTo(usunitfrom);
    await _doUpdatePartTo(uspartfrom);
  }

  Future _doUpdateSingleUnit() async {
    await _doUpdateUnitTo(usunitfrom);
    await _doUpdatePartFrom(1);
    await _doUpdatePartTo(partCount);
  }

  Future _doUpdateUnitFrom(int v, {bool check = true}) async {
    if (check && usunitfrom == v) return;
    await _userSettingService.updateByInt(INFO_USUNITFROM, usunitfrom = v);
  }

  Future _doUpdatePartFrom(int v, {bool check = true}) async {
    if (check && uspartfrom == v) return;
    await _userSettingService.updateByInt(INFO_USPARTFROM, uspartfrom = v);
  }

  Future _doUpdateUnitTo(int v, {bool check = true}) async {
    if (check && usunitto == v) return;
    await _userSettingService.updateByInt(INFO_USUNITTO, usunitto = v);
  }

  Future _doUpdatePartTo(int v, {bool check = true}) async {
    if (check && uspartto == v) return;
    await _userSettingService.updateByInt(INFO_USPARTTO, uspartto = v);
  }
}
