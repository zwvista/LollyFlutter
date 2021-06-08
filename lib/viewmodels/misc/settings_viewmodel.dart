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

  String? getUSValue(MUserSettingInfo? info) {
    final o = lstUserSettings.firstWhereOrNull((o2) => o2.id == info?.usersettingid);
    switch (info?.valueid) {
      case 1:
        return o?.value1;
      case 2:
        return o?.value2;
      case 3:
        return o?.value3;
      case 4:
        return o?.value4;
      default:
        return null;
    }
  }

  void setUSValue(MUserSettingInfo? info, String value) {
    final o = lstUserSettings.firstWhereOrNull((o2) => o2.id == info?.usersettingid);
    switch (info?.valueid) {
      case 1:
        o?.value1 = value;
        break;
      case 2:
        o?.value2 = value;
        break;
      case 3:
        o?.value3 = value;
        break;
      case 4:
        o?.value4 = value;
        break;
    }
  }

  late MUserSettingInfo INFO_USLANG;
  int get uslang => int.parse(getUSValue(INFO_USLANG) ?? "0");
  set uslang(int value) => setUSValue(INFO_USLANG, value.toString());
  late MUserSettingInfo INFO_USVOICE;
  int get usvoice => int.parse(getUSValue(INFO_USVOICE) ?? "0");
  set usvoice(int value) => setUSValue(INFO_USVOICE, value.toString());
  late MUserSettingInfo INFO_USTEXTBOOK;
  int get ustextbook => int.parse(getUSValue(INFO_USTEXTBOOK) ?? "0");
  set ustextbook(int value) => setUSValue(INFO_USTEXTBOOK, value.toString());
  late MUserSettingInfo INFO_USDICTREFERENCE;
  String get usdictreference => getUSValue(INFO_USDICTREFERENCE) ?? "";
  set usdictreference(String value) => setUSValue(INFO_USDICTREFERENCE, value);
  late MUserSettingInfo INFO_USDICTNOTE;
  int get usdictnote => int.parse(getUSValue(INFO_USDICTNOTE) ?? "0");
  set usdictnote(int value) => setUSValue(INFO_USDICTNOTE, value.toString());
  late MUserSettingInfo INFO_USDICTTRANSLATION;
  int get usdicttranslation =>
      int.parse(getUSValue(INFO_USDICTTRANSLATION) ?? "0");
  set usdicttranslation(int value) =>
      setUSValue(INFO_USDICTTRANSLATION, value.toString());

  late MUserSettingInfo INFO_USUNITFROM;
  late RxCommand<int?, void> usunitfrom_;
  int get usunitfrom => int.parse(getUSValue(INFO_USUNITFROM) ?? "0");
  String get usunitfromstr => selectedTextbook?.unitstr(usunitfrom) ?? "";
  set usunitfrom(int value) => setUSValue(INFO_USUNITFROM, value.toString());
  late RxCommand<void, void> updateUnitFrom;

  late MUserSettingInfo INFO_USPARTFROM;
  late RxCommand<int?, void> uspartfrom_;
  int get uspartfrom => int.parse(getUSValue(INFO_USPARTFROM) ?? "0");
  String get uspartfromstr => selectedTextbook?.partstr(uspartfrom) ?? "";
  set uspartfrom(int value) => setUSValue(INFO_USPARTFROM, value.toString());
  late RxCommand<void, void> updatePartFrom;

  late MUserSettingInfo INFO_USUNITTO;
  late RxCommand<int?, void> usunitto_;
  int get usunitto => int.parse(getUSValue(INFO_USUNITTO) ?? "0");
  String get usunittostr => selectedTextbook?.unitstr(usunitto) ?? "";
  set usunitto(int value) => setUSValue(INFO_USUNITTO, value.toString());
  late RxCommand<void, void> updateUnitTo;

  late MUserSettingInfo INFO_USPARTTO;
  late RxCommand<int?, void> uspartto_;
  int get uspartto => int.parse(getUSValue(INFO_USPARTTO) ?? "0");
  String get usparttostr => selectedTextbook?.partstr(uspartto) ?? "";
  set uspartto(int value) => setUSValue(INFO_USPARTTO, value.toString());
  late RxCommand<void, void> updatePartTo;

  int get usunitpartfrom => usunitfrom * 10 + uspartfrom;
  int get usunitpartto => usunitto * 10 + uspartto;
  bool get isSingleUnitPart => usunitpartfrom == usunitpartto;
  bool get isInvaidUnitPart => usunitpartfrom > usunitpartto;

  List<MLanguage> lstLanguages = [];
  late RxCommand<MLanguage, void> selectedLang_;
  MLanguage? selectedLang;
  late RxCommand<void, void> updateLang;
  List<MVoice> lstVoices = [];
  late RxCommand<MVoice, void> selectedVoice_;
  MVoice? selectedVoice;
  late RxCommand<void, void> updateVoice;
  List<MTextbook> lstTextbooks = [];
  List<MSelectItem> lstTextbookFilters = [];
  late RxCommand<MTextbook, void> selectedTextbook_;
  MTextbook? selectedTextbook;
  late RxCommand<void, void> updateTextbook;
  List<MDictionary> lstDictsReference = [];
  late RxCommand<MDictionary, void> selectedDictReference_;
  MDictionary? selectedDictReference;
  late RxCommand<void, void> updateDictReference;
  List<MDictionary> lstDictsNote = [];
  late RxCommand<MDictionary, void> selectedDictNote_;
  MDictionary? selectedDictNote;
  late RxCommand<void, void> updateDictNote;
  List<MDictionary> lstDictsTranslation = [];
  late RxCommand<MDictionary, void> selectedDictTranslation_;
  MDictionary? selectedDictTranslation;
  late RxCommand<void, void> updateDictTranslation;
  List<MAutoCorrect> lstAutoCorrect = [];

  final _languageService = LanguageService();
  final _usMappingService = USMappingService();
  final _userSettingService = UserSettingService();
  final _dictionaryService = DictionaryService();
  final _textbookService = TextbookService();
  final _autoCorrectService = AutoCorrectService();
  final _voiceService = VoiceService();

  List<MSelectItem> get lstUnits => selectedTextbook?.lstUnits ?? [];
  List<MSelectItem> get lstParts => selectedTextbook?.lstParts ?? [];
  int get unitCount => lstUnits.length;
  int get partCount => lstParts.length;
  bool get isSingleUnit =>
      usunitfrom == usunitto && uspartfrom == 1 && uspartto == partCount;
  bool get isSinglePart => partCount == 1;

  static final List<MSelectItem> lstToTypes = [
    MSelectItem(0, "Unit"),
    MSelectItem(1, "Part"),
    MSelectItem(2, "To")
  ];
  late RxCommand<UnitPartToType, void> toType_;
  UnitPartToType toType = UnitPartToType.To;
  late RxCommand<void, void> setToType;

  bool unitToEnabled = true;
  bool partToEnabled = true;
  bool previousEnabled = true;
  bool nextEnabled = true;
  String previousText = "Previous";
  String nextText = "Next";
  bool partFromEnabled = true;

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
            ? selectedLang!.id
            : o.level == 2
                ? selectedTextbook!.id
                : 0;
    var o2 = lstUserSettings
        .firstWhere((v) => v.kind == o.kind && v.entityid == entityid);
    return MUserSettingInfo(o2.id, o.valueid);
  }

  SettingsViewModel() {
    updateLang = RxCommand.createAsyncNoParamNoResult(() async {
      if (selectedLang == null) return;
      final newVal = selectedLang!.id;
      final dirty = uslang != newVal;
      uslang = newVal;
      INFO_USTEXTBOOK = _getUSInfo(MUSMapping.NAME_USTEXTBOOK);
      INFO_USDICTREFERENCE = _getUSInfo(MUSMapping.NAME_USDICTREFERENCE);
      INFO_USDICTNOTE = _getUSInfo(MUSMapping.NAME_USDICTNOTE);
      INFO_USDICTTRANSLATION = _getUSInfo(MUSMapping.NAME_USDICTTRANSLATION);
      INFO_USVOICE = _getUSInfo(MUSMapping.NAME_USVOICE);
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
      if (lstVoices.isNotEmpty) {
        final v0 = lstVoices[0];
        var ttsVoices = (await flutterTts.getVoices) as List;
        ttsVoices = ttsVoices
            .where((o) => lstVoices.any((o2) => o["locale"] == o2.voicelang))
            .toList();
        lstVoices = ttsVoices
            .asMap()
            .map((k, v) => MapEntry(
                k,
                MVoice()
                  ..id = k
                  ..langid = v0.langid
                  ..voicetypeid = v0.voicetypeid
                  ..voicelang = v0.voicelang
                  ..voicename = v["name"]))
            .values
            .toList();
      }
      selectedDictReference_(lstDictsReference
              .firstWhereOrNull((o) => o.dictid.toString() == usdictreference) ??
          lstDictsReference.firstWhereOrNull((_) => true));
      selectedDictNote_(
          lstDictsNote.firstWhereOrNull((o) => o.dictid == usdictnote) ??
              lstDictsNote.firstWhereOrNull((_) => true));
      selectedDictTranslation_(lstDictsTranslation
              .firstWhereOrNull((o) => o.dictid == usdicttranslation) ??
          lstDictsTranslation.firstWhereOrNull((_) => true));
      selectedTextbook_(lstTextbooks.firstWhereOrNull((o) => o.id == ustextbook) ??
          lstTextbooks.firstWhereOrNull((_) => true));
      selectedVoice_(lstVoices.firstWhereOrNull((o) => o.id == usvoice) ??
          lstVoices.firstWhereOrNull((_) => true));
      if (dirty) await _userSettingService.updateByInt(INFO_USLANG, uslang);
    });
    selectedLang_ = RxCommand.createSync((MLanguage v) { selectedLang = v; });
    selectedLang_.listen(updateLang);

    updateVoice = RxCommand.createAsyncNoParamNoResult(() async {
      if (selectedVoice == null) return;
      final newVal = selectedVoice!.id;
      final dirty = usvoice != newVal;
      usvoice = newVal;
      flutterTts.setVoice({"name": selectedVoice!.voicename, "locale": selectedVoice!.voicelang});
      if (dirty) await _userSettingService.updateByInt(INFO_USVOICE, usvoice);
    });
    selectedVoice_ = RxCommand.createSync((MVoice v) { selectedVoice = v; });
    selectedVoice_.listen(updateVoice);

    updateTextbook = RxCommand.createAsyncNoParamNoResult(() async {
      if (selectedTextbook == null) return;
      final newVal = selectedTextbook!.id;
      final dirty = ustextbook != newVal;
      ustextbook = newVal;
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
      if (dirty)
        await _userSettingService.updateByInt(INFO_USTEXTBOOK, ustextbook);
    });
    selectedTextbook_ = RxCommand.createSync((MTextbook v) { selectedTextbook = v; });
    selectedTextbook_.listen(updateTextbook);

    updateDictReference = RxCommand.createAsyncNoParamNoResult(() async {
      if (selectedDictReference == null) return;
      final newVal = selectedDictReference!.dictid.toString();
      final dirty = usdictreference != newVal;
      usdictreference = newVal;
      if (dirty)
        await _userSettingService.updateByString(
            INFO_USDICTREFERENCE, usdictreference);
    });
    selectedDictReference_ = RxCommand.createSync((MDictionary v) { selectedDictReference = v; });
    selectedDictReference_.listen(updateDictReference);

    updateDictNote = RxCommand.createAsyncNoParamNoResult(() async {
      if (selectedDictNote == null) return;
      final newVal = selectedDictNote!.dictid;
      final dirty = usdictnote != newVal;
      usdictnote = newVal;
      if (dirty)
        await _userSettingService.updateByInt(INFO_USDICTNOTE, usdictnote);
    });
    selectedDictNote_ = RxCommand.createSync((MDictionary v) { selectedDictNote = v; });
    selectedDictNote_.listen(updateDictNote);

    updateDictTranslation = RxCommand.createAsyncNoParamNoResult(() async {
      if (selectedDictTranslation == null) return;
      final newVal = selectedDictTranslation!.dictid;
      final dirty = usdicttranslation != newVal;
      usdicttranslation = newVal;
      if (dirty)
        await _userSettingService.updateByInt(
            INFO_USDICTTRANSLATION, usdicttranslation);
    });
    selectedDictTranslation_ = RxCommand.createSync((MDictionary v) { selectedDictTranslation = v; });
    selectedDictTranslation_.listen(updateDictTranslation);

    updateUnitFrom = RxCommand.createAsyncNoParamNoResult(() async {
      await _doUpdateUnitFrom(usunitfrom);
      if (toType == UnitPartToType.Unit)
        await _doUpdateSingleUnit();
      else if (toType == UnitPartToType.Part || isInvaidUnitPart)
        await _doUpdateUnitPartTo();
    });
    usunitfrom_ = RxCommand.createSync((int? v) { usunitfrom = v!; });
    usunitfrom_.listen(updateUnitFrom);

    updatePartFrom = RxCommand.createAsyncNoParamNoResult(() async {
      await _doUpdatePartFrom(uspartfrom);
      if (toType == UnitPartToType.Part || isInvaidUnitPart)
        await _doUpdateUnitPartTo();
    });
    uspartfrom_ = RxCommand.createSync((int? v) { uspartfrom = v!; });
    uspartfrom_.listen(updatePartFrom);

    updateUnitTo = RxCommand.createAsyncNoParamNoResult(() async {
      await _doUpdateUnitTo(usunitto);
      if (isInvaidUnitPart) await _doUpdateUnitPartFrom();
    });
    usunitto_ = RxCommand.createSync((int? v) { usunitto = v!; });
    usunitto_.listen(updateUnitTo);

    updatePartTo = RxCommand.createAsyncNoParamNoResult(() async {
      await _doUpdatePartTo(uspartto);
      if (isInvaidUnitPart) await _doUpdateUnitPartFrom();
    });
    uspartto_ = RxCommand.createSync((int? v) { uspartto = v!; });
    uspartto_.listen(updatePartTo);

    setToType = RxCommand.createAsyncNoParamNoResult(() async {
      final b = toType == UnitPartToType.To;
      unitToEnabled = b;
      partToEnabled = b && !isSinglePart;
      previousEnabled = !b;
      nextEnabled = !b;
      final b2 = toType != UnitPartToType.Unit;
      final t = !b2 ? "Unit" : "Part";
      previousText = "Previous " + t;
      nextText = "Next " + t;
      partFromEnabled = b2 && !isSinglePart;
      if (toType == UnitPartToType.Unit)
        await _doUpdateSingleUnit();
      else if (toType == UnitPartToType.Part) await _doUpdateUnitPartTo();
    });
    toType_ = RxCommand.createSync((UnitPartToType v) { toType = v; });
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

  Future _doUpdateUnitFrom(int newVal) async {
    if (usunitfrom == newVal) return;
    usunitfrom_(newVal);
    await _userSettingService.updateByInt(INFO_USUNITFROM, usunitfrom = newVal);
  }

  Future _doUpdatePartFrom(int newVal) async {
    if (uspartfrom == newVal) return;
    uspartfrom_(newVal);
    await _userSettingService.updateByInt(INFO_USPARTFROM, uspartfrom = newVal);
  }

  Future _doUpdateUnitTo(int newVal) async {
    if (usunitto == newVal) return;
    usunitto_(newVal);
    await _userSettingService.updateByInt(INFO_USUNITTO, usunitto = newVal);
  }

  Future _doUpdatePartTo(int newVal) async {
    if (uspartto == newVal) return;
    uspartto_(newVal);
    await _userSettingService.updateByInt(INFO_USPARTTO, uspartto = newVal);
  }

  static const ZeroNote = "O";

  Future<String> retrieveNote(String word) async {
    if (selectedDictNote == null) return "";
    var url = selectedDictNote!.urlString(word, lstAutoCorrect);
    var html = await BaseService.getHtmlByUrl(url);
    return HtmlTransformService.extractTextFromHtml(
        html, selectedDictNote!.transform, "", (text, _) => text);
  }

  Future retrieveNotes(int wordCount, bool Function(int) isNoteEmpty,
      Future Function(int) getOne) async {
    if (selectedDictNote == null) return;
    for (int i = 0;;) {
      await Future.delayed(Duration(milliseconds: selectedDictNote!.wait));
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
