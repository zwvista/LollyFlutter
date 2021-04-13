import 'package:lolly_flutter/models/misc/mautocorrect.dart';
import 'package:lolly_flutter/models/misc/mcommon.dart';
import 'package:lolly_flutter/models/misc/mdictionary.dart';
import 'package:lolly_flutter/models/misc/mlanguage.dart';
import 'package:lolly_flutter/models/misc/mtextbook.dart';
import 'package:lolly_flutter/models/misc/musersetting.dart';
import 'package:lolly_flutter/models/misc/musmapping.dart';
import 'package:lolly_flutter/models/misc/mvoice.dart';
import 'package:lolly_flutter/services/misc/autocorrect_service.dart';
import 'package:lolly_flutter/services/misc/base_service.dart';
import 'package:lolly_flutter/services/misc/dictionary_service.dart';
import 'package:lolly_flutter/services/misc/html_transform_service.dart';
import 'package:lolly_flutter/services/misc/language_service.dart';
import 'package:lolly_flutter/services/misc/textbook_service.dart';
import 'package:lolly_flutter/services/misc/usersetting_service.dart';
import 'package:lolly_flutter/services/misc/usmapping_service.dart';
import 'package:lolly_flutter/services/misc/voice_service.dart';
import 'package:rx_command/rx_command.dart';

import '../../main.dart';

class SettingsViewModel {
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
  final usunitfrom_ = RxCommand.createSync((int v) => v);
  int get usunitfrom => int.parse(getUSValue(INFO_USUNITFROM) ?? "0");
  String get usunitfromstr => selectedTextbook?.unitstr(usunitfrom) ?? "";
  set usunitfrom(int value) => setUSValue(INFO_USUNITFROM, value.toString());
  RxCommand<int, void> updateUnitFrom;

  MUserSettingInfo INFO_USPARTFROM;
  final uspartfrom_ = RxCommand.createSync((int v) => v);
  int get uspartfrom => int.parse(getUSValue(INFO_USPARTFROM) ?? "0");
  String get uspartfromstr => selectedTextbook?.partstr(uspartfrom) ?? "";
  set uspartfrom(int value) => setUSValue(INFO_USPARTFROM, value.toString());
  RxCommand<int, void> updatePartFrom;

  MUserSettingInfo INFO_USUNITTO;
  final usunitto_ = RxCommand.createSync((int v) => v);
  int get usunitto => int.parse(getUSValue(INFO_USUNITTO) ?? "0");
  String get usunittostr => selectedTextbook?.unitstr(usunitto) ?? "";
  set usunitto(int value) => setUSValue(INFO_USUNITTO, value.toString());
  RxCommand<int, void> updateUnitTo;

  MUserSettingInfo INFO_USPARTTO;
  final uspartto_ = RxCommand.createSync((int v) => v);
  int get uspartto => int.parse(getUSValue(INFO_USPARTTO) ?? "0");
  String get usparttostr => selectedTextbook?.partstr(uspartto) ?? "";
  set uspartto(int value) => setUSValue(INFO_USPARTTO, value.toString());
  RxCommand<int, void> updatePartTo;

  int get usunitpartfrom => usunitfrom * 10 + uspartfrom;
  int get usunitpartto => usunitto * 10 + uspartto;
  bool get isSingleUnitPart => usunitpartfrom == usunitpartto;
  bool get isInvaidUnitPart => usunitpartfrom > usunitpartto;

  List<MLanguage> lstLanguages = [];
  final selectedLang_ = RxCommand.createSync((MLanguage v) => v);
  MLanguage get selectedLang => selectedLang_.lastResult;
  RxCommand<MLanguage, void> setSelectedLang;
  List<MVoice> lstVoices = [];
  final selectedVoice_ = RxCommand.createSync((MVoice v) => v);
  MVoice get selectedVoice => selectedVoice_.lastResult;
  RxCommand<MVoice, void> setSelectedVoice;
  dynamic ttsVoices;
  List<MTextbook> lstTextbooks = [];
  List<MSelectItem> lstTextbookFilters = [];
  final selectedTextbook_ = RxCommand.createSync((MTextbook v) => v);
  MTextbook get selectedTextbook => selectedTextbook_.lastResult;
  RxCommand<MTextbook, void> setSelectedTextbook;
  List<MDictionary> lstDictsReference = [];
  final selectedDictReference_ = RxCommand.createSync((MDictionary v) => v);
  MDictionary get selectedDictReference => selectedDictReference_.lastResult;
  RxCommand<MDictionary, void> setSelectedDictReference;
  List<MDictionary> lstDictsNote = [];
  final selectedDictNote_ = RxCommand.createSync((MDictionary v) => v);
  MDictionary get selectedDictNote => selectedDictNote_.lastResult;
  RxCommand<MDictionary, void> setSelectedDictNote;
  List<MDictionary> lstDictsTranslation = [];
  final selectedDictTranslation_ = RxCommand.createSync((MDictionary v) => v);
  MDictionary get selectedDictTranslation =>
      selectedDictTranslation_.lastResult;
  RxCommand<MDictionary, void> setSelectedDictTranslation;
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
  final toType_ = RxCommand.createSync((UnitPartToType v) => v,
      initialLastResult: UnitPartToType.To);
  UnitPartToType get toType => toType_.lastResult;
  RxCommand<UnitPartToType, void> setToType;

  bool unitToIsEnabled = true;
  bool partToIsEnabled = true;
  bool previousIsEnabled = true;
  bool nextIsEnabled = true;
  String previousText = "Previous";
  String nextText = "Next";
  bool partFromIsEnabled = true;

  static final scopeWordFilters = ["Word", "Note"];
  static final scopePhraseFilters = ["Phrase", "Translation"];
  static final scopePatternFilters = ["Pattern", "Note", "Tags"];
  static final reviewModes = [
    MSelectItem(0, "Review(Auto)"),
    MSelectItem(1, "Review(Manual)"),
    MSelectItem(2, "Test"),
    MSelectItem(3, "Textbook"),
  ];

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

  SettingsViewModel() {
    setSelectedLang = RxCommand.createAsyncNoResult((v) async {
      final isinit = uslang == v.id;
      uslang = v.id;
      INFO_USTEXTBOOK = _getUSInfo(MUSMapping.NAME_USTEXTBOOK);
      INFO_USDICTREFERENCE = _getUSInfo(MUSMapping.NAME_USDICTREFERENCE);
      INFO_USDICTNOTE = _getUSInfo(MUSMapping.NAME_USDICTNOTE);
      INFO_USDICTTRANSLATION = _getUSInfo(MUSMapping.NAME_USDICTTRANSLATION);
      INFO_USVOICE = _getUSInfo(MUSMapping.NAME_USWINDOWSVOICE);
      selectedDictReference_(null);
      lstDictsReference =
          await _dictionaryService.getDictsReferenceByLang(uslang);
      selectedDictNote_(null);
      lstDictsNote = await _dictionaryService.getDictsNoteByLang(uslang);
      selectedDictTranslation_(null);
      lstDictsTranslation =
          await _dictionaryService.getDictsTranslationByLang(uslang);
      selectedTextbook_(null);
      lstTextbooks = await _textbookService.getDataByLang(uslang);
      lstTextbookFilters =
          lstTextbooks.map((o) => MSelectItem(o.id, o.textbookname)).toList();
      lstTextbookFilters.insert(0, MSelectItem(0, "All Textbooks"));
      lstAutoCorrect = await _autoCorrectService.getDataByLang(uslang);
      selectedVoice_(null);
      lstVoices = await _voiceService.getDataByLang(uslang);
      ttsVoices = await flutterTts.getVoices;
      selectedDictReference_(lstDictsReference
          .firstWhere((o) => o.dictid.toString() == usdictreference));
      selectedDictNote_(lstDictsNote.firstWhere((o) => o.dictid == usdictnote));
      selectedDictTranslation_(
          lstDictsTranslation.firstWhere((o) => o.dictid == usdicttranslation));
      selectedTextbook_(lstTextbooks.firstWhere((o) => o.id == ustextbook));
      selectedVoice_(lstVoices.first);
      if (!isinit) await _userSettingService.updateByInt(INFO_USLANG, uslang);
    });
    selectedLang_.listen(setSelectedLang);

    setSelectedVoice = RxCommand.createAsyncNoResult((v) async {
      usvoice = v.id;
      await _userSettingService.updateByInt(INFO_USVOICE, usvoice);
    });
    selectedVoice_.listen(setSelectedVoice);

    setSelectedTextbook = RxCommand.createAsyncNoResult((v) async {
      ustextbook = v.id;
      INFO_USUNITFROM = _getUSInfo(MUSMapping.NAME_USUNITFROM);
      usunitfrom_(usunitfrom);
      INFO_USPARTFROM = _getUSInfo(MUSMapping.NAME_USPARTFROM);
      uspartfrom_(uspartfrom);
      INFO_USUNITTO = _getUSInfo(MUSMapping.NAME_USUNITTO);
      usunitto_(usunitto);
      INFO_USPARTTO = _getUSInfo(MUSMapping.NAME_USPARTTO);
      uspartto_(uspartto);
      toType_(isSingleUnit
          ? UnitPartToType.Unit
          : isSingleUnitPart
              ? UnitPartToType.Part
              : UnitPartToType.To);
      await _userSettingService.updateByInt(INFO_USTEXTBOOK, ustextbook);
    });
    selectedTextbook_.listen(setSelectedTextbook);

    setSelectedDictReference = RxCommand.createAsyncNoResult((v) async {
      usdictreference = v.dictid.toString();
      await _userSettingService.updateByString(
          INFO_USDICTREFERENCE, usdictreference);
    });
    selectedDictReference_.listen(setSelectedDictReference);

    setSelectedDictNote = RxCommand.createAsyncNoResult((v) async {
      usdictnote = v.dictid;
      await _userSettingService.updateByInt(INFO_USDICTNOTE, usdictnote);
    });
    selectedDictNote_.listen(setSelectedDictNote);

    setSelectedDictTranslation = RxCommand.createAsyncNoResult((v) async {
      usdicttranslation = v.dictid;
      await _userSettingService.updateByInt(
          INFO_USDICTTRANSLATION, usdicttranslation);
    });
    selectedDictTranslation_.listen(setSelectedDictTranslation);

    updateUnitFrom = RxCommand.createAsyncNoResult((v) async {
      await _doUpdateUnitFrom(v, check: false);
      if (toType == UnitPartToType.Unit)
        await _doUpdateSingleUnit();
      else if (toType == UnitPartToType.Part || isInvaidUnitPart)
        await _doUpdateUnitPartTo();
    });
    usunitfrom_.listen(updateUnitFrom);

    updatePartFrom = RxCommand.createAsyncNoResult((v) async {
      await _doUpdatePartFrom(v, check: false);
      if (toType == UnitPartToType.Part || isInvaidUnitPart)
        await _doUpdateUnitPartTo();
    });
    uspartfrom_.listen(updatePartFrom);

    updateUnitTo = RxCommand.createAsyncNoResult((v) async {
      await _doUpdateUnitTo(v, check: false);
      if (isInvaidUnitPart) await _doUpdateUnitPartFrom();
    });
    usunitto_.listen(updateUnitTo);

    updatePartTo = RxCommand.createAsyncNoResult((v) async {
      await _doUpdatePartTo(v, check: false);
      if (isInvaidUnitPart) await _doUpdateUnitPartFrom();
    });
    uspartto_.listen(updatePartTo);

    setToType = RxCommand.createAsyncNoResult((v) async {
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
    });
    toType_.listen(setToType);
  }

  Future getData() async {
    lstLanguages = await _languageService.getData();
    lstUSMappings = await _usMappingService.getData();
    lstUserSettings = await _userSettingService.getData();
    INFO_USLANG = _getUSInfo(MUSMapping.NAME_USLANG);
    selectedLang_(lstLanguages.firstWhere((o) => o.id == uslang));
  }

  String autoCorrectInput(String text) => _autoCorrectService.autoCorrect(
      text, lstAutoCorrect, (o) => o.input, (o) => o.extended);

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
    } else if (uspartfrom < partCount) {
      await _doUpdatePartFrom(uspartfrom + 1);
      await _doUpdateUnitPartTo();
    } else if (usunitfrom < unitCount) {
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
    usunitfrom_(v);
    await _userSettingService.updateByInt(INFO_USUNITFROM, usunitfrom = v);
  }

  Future _doUpdatePartFrom(int v, {bool check = true}) async {
    if (check && uspartfrom == v) return;
    uspartfrom_(v);
    await _userSettingService.updateByInt(INFO_USPARTFROM, uspartfrom = v);
  }

  Future _doUpdateUnitTo(int v, {bool check = true}) async {
    if (check && usunitto == v) return;
    usunitto_(v);
    await _userSettingService.updateByInt(INFO_USUNITTO, usunitto = v);
  }

  Future _doUpdatePartTo(int v, {bool check = true}) async {
    if (check && uspartto == v) return;
    uspartto_(v);
    await _userSettingService.updateByInt(INFO_USPARTTO, uspartto = v);
  }

  static const ZeroNote = "O";

  Future<String> retrieveNote(String word) async {
    if (selectedDictNote == null) return "";
    var url = selectedDictNote.urlString(word, lstAutoCorrect);
    var html = await BaseService.getHtmlByUrl(url);
    return HtmlTransformService.extractTextFromHtml(
        html, selectedDictNote.transform, "", (text, _) => text);
  }

  Future retrieveNotes(int wordCount, bool Function(int) isNoteEmpty,
      Future Function(int) getOne) async {
    if (selectedDictNote == null) return;
    for (int i = 0;;) {
      await Future.delayed(Duration(milliseconds: selectedDictNote.wait));
      while (i < wordCount && !isNoteEmpty(i)) i++;
      if (i > wordCount) break;
      if (i < wordCount) await getOne(i);
      i++;
    }
  }

  Future clearNotes(int wordCount, bool Function(int) isNoteEmpty,
      Future Function(int) getOne) async {
    if (selectedDictNote == null) return;
    for (int i = 0; i < wordCount;) {
      while (i < wordCount && !isNoteEmpty(i)) i++;
      if (i < wordCount) await getOne(i);
      i++;
    }
  }
}
