import 'package:flutter_command/flutter_command.dart';
import 'package:lolly_flutter/models/misc/mautocorrect.dart';
import 'package:lolly_flutter/models/misc/mcommon.dart';
import 'package:lolly_flutter/models/misc/mdictionary.dart';
import 'package:lolly_flutter/models/misc/mlanguage.dart';
import 'package:lolly_flutter/models/misc/mtextbook.dart';
import 'package:lolly_flutter/models/misc/musersetting.dart';
import 'package:lolly_flutter/models/misc/musmapping.dart';
import 'package:lolly_flutter/models/misc/mvoice.dart';
import 'package:lolly_flutter/services/blogs/unitblogpost_service.dart';
import 'package:lolly_flutter/services/misc/autocorrect_service.dart';
import 'package:lolly_flutter/services/misc/base_service.dart';
import 'package:lolly_flutter/services/misc/dictionary_service.dart';
import 'package:lolly_flutter/services/misc/html_transform_service.dart';
import 'package:lolly_flutter/services/misc/language_service.dart';
import 'package:lolly_flutter/services/misc/textbook_service.dart';
import 'package:lolly_flutter/services/misc/usersetting_service.dart';
import 'package:lolly_flutter/services/misc/usmapping_service.dart';
import 'package:lolly_flutter/services/misc/voice_service.dart';

import '../../main.dart';

class SettingsViewModel {
  List<MUSMapping> lstUSMappings = [];
  List<MUserSetting> lstUserSettings = [];

  String? getUSValue(MUserSettingInfo info) {
    final o =
        lstUserSettings.firstWhereOrNull((o2) => o2.id == info.usersettingid);
    switch (info.valueid) {
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

  void setUSValue(MUserSettingInfo info, String value) {
    final o =
        lstUserSettings.firstWhereOrNull((o2) => o2.id == info.usersettingid);
    switch (info.valueid) {
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

  var INFO_USLANG = MUserSettingInfo();
  int get uslang => int.parse(getUSValue(INFO_USLANG) ?? "0");
  set uslang(int value) => setUSValue(INFO_USLANG, value.toString());
  var INFO_USVOICE = MUserSettingInfo();
  int get usvoice => int.parse(getUSValue(INFO_USVOICE) ?? "0");
  set usvoice(int value) => setUSValue(INFO_USVOICE, value.toString());
  var INFO_USTEXTBOOK = MUserSettingInfo();
  int get ustextbook => int.parse(getUSValue(INFO_USTEXTBOOK) ?? "0");
  set ustextbook(int value) => setUSValue(INFO_USTEXTBOOK, value.toString());
  var INFO_USDICTREFERENCE = MUserSettingInfo();
  String get usdictreference => getUSValue(INFO_USDICTREFERENCE) ?? "";
  set usdictreference(String value) => setUSValue(INFO_USDICTREFERENCE, value);
  var INFO_USDICTNOTE = MUserSettingInfo();
  int get usdictnote => int.parse(getUSValue(INFO_USDICTNOTE) ?? "0");
  set usdictnote(int value) => setUSValue(INFO_USDICTNOTE, value.toString());
  var INFO_USDICTTRANSLATION = MUserSettingInfo();
  int get usdicttranslation =>
      int.parse(getUSValue(INFO_USDICTTRANSLATION) ?? "0");
  set usdicttranslation(int value) =>
      setUSValue(INFO_USDICTTRANSLATION, value.toString());

  var INFO_USUNITFROM = MUserSettingInfo();
  int get usunitfrom => int.parse(getUSValue(INFO_USUNITFROM) ?? "0");
  String get usunitfromstr => selectedTextbook?.unitstr(usunitfrom) ?? "";
  set usunitfrom(int value) => setUSValue(INFO_USUNITFROM, value.toString());
  late Command<int?, void> selectedUnitFrom;
  late Command<void, void> updateUnitFrom;

  var INFO_USPARTFROM = MUserSettingInfo();
  int get uspartfrom => int.parse(getUSValue(INFO_USPARTFROM) ?? "0");
  String get uspartfromstr => selectedTextbook?.partstr(uspartfrom) ?? "";
  set uspartfrom(int value) => setUSValue(INFO_USPARTFROM, value.toString());
  late Command<int?, void> selectedPartFrom;
  late Command<void, void> updatePartFrom;

  var INFO_USUNITTO = MUserSettingInfo();
  int get usunitto => int.parse(getUSValue(INFO_USUNITTO) ?? "0");
  String get usunittostr => selectedTextbook?.unitstr(usunitto) ?? "";
  set usunitto(int value) => setUSValue(INFO_USUNITTO, value.toString());
  late Command<int?, void> selectedUnitTo;
  late Command<void, void> updateUnitTo;

  var INFO_USPARTTO = MUserSettingInfo();
  int get uspartto => int.parse(getUSValue(INFO_USPARTTO) ?? "0");
  String get usparttostr => selectedTextbook?.partstr(uspartto) ?? "";
  set uspartto(int value) => setUSValue(INFO_USPARTTO, value.toString());
  late Command<int?, void> selectedPartTo;
  late Command<void, void> updatePartTo;

  int get usunitpartfrom => usunitfrom * 10 + uspartfrom;
  int get usunitpartto => usunitto * 10 + uspartto;
  bool get isSingleUnitPart => usunitpartfrom == usunitpartto;
  bool get isInvaidUnitPart => usunitpartfrom > usunitpartto;

  List<MLanguage> lstLanguages = [];
  late Command<MLanguage?, void> selectedLang_;
  MLanguage? selectedLang;
  late Command<void, void> updateLang;
  List<MVoice> lstVoices = [];
  late Command<MVoice?, void> selectedVoice_;
  MVoice? selectedVoice;
  late Command<void, void> updateVoice;
  List<MTextbook> lstTextbooks = [];
  List<MSelectItem> lstTextbookFilters = [];
  List<MSelectItem> lstOnlineTextbookFilters = [];
  late Command<MTextbook?, void> selectedTextbook_;
  MTextbook? selectedTextbook;
  late Command<void, void> updateTextbook;
  List<MDictionary> lstDictsReference = [];
  late Command<MDictionary?, void> selectedDictReference_;
  MDictionary? selectedDictReference;
  late Command<void, void> updateDictReference;
  List<MDictionary> lstDictsNote = [];
  late Command<MDictionary?, void> selectedDictNote_;
  MDictionary? selectedDictNote;
  late Command<void, void> updateDictNote;
  List<MDictionary> lstDictsTranslation = [];
  late Command<MDictionary?, void> selectedDictTranslation_;
  MDictionary? selectedDictTranslation;
  late Command<void, void> updateDictTranslation;
  List<MAutoCorrect> lstAutoCorrect = [];

  final _languageService = LanguageService();
  final _usMappingService = USMappingService();
  final _userSettingService = UserSettingService();
  final _dictionaryService = DictionaryService();
  final _textbookService = TextbookService();
  final _autoCorrectService = AutoCorrectService();
  final _voiceService = VoiceService();
  final _unitBlogPostService = UnitBlogPostService();

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
  late Command<UnitPartToType, void> toType_;
  UnitPartToType toType = UnitPartToType.To;
  late Command<void, void> setToType;

  bool unitToEnabled = true;
  bool partToEnabled = true;
  bool previousEnabled = true;
  bool nextEnabled = true;
  String previousText = "Previous";
  String nextText = "Next";
  bool partFromEnabled = true;

  static final scopeWordFilters = ["Word", "Note"];
  static final scopePhraseFilters = ["Phrase", "Translation"];
  static final scopePatternFilters = ["Pattern", "Tags"];
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
    return MUserSettingInfo(usersettingid: o2.id, valueid: o.valueid);
  }

  SettingsViewModel() {
    updateLang = Command.createAsyncNoParamNoResult(() async {
      if (selectedLang == null) return;
      final newVal = selectedLang!.id;
      final dirty = uslang != newVal;
      uslang = newVal;
      INFO_USTEXTBOOK = _getUSInfo(MUSMapping.NAME_USTEXTBOOK);
      INFO_USDICTREFERENCE = _getUSInfo(MUSMapping.NAME_USDICTREFERENCE);
      INFO_USDICTNOTE = _getUSInfo(MUSMapping.NAME_USDICTNOTE);
      INFO_USDICTTRANSLATION = _getUSInfo(MUSMapping.NAME_USDICTTRANSLATION);
      INFO_USVOICE = _getUSInfo(MUSMapping.NAME_USVOICE);
      final res1 = _dictionaryService.getDictsReferenceByLang(uslang);
      final res2 = _dictionaryService.getDictsNoteByLang(uslang);
      final res3 = _dictionaryService.getDictsTranslationByLang(uslang);
      final res4 = _textbookService.getDataByLang(uslang);
      final res5 = _autoCorrectService.getDataByLang(uslang);
      final res6 = _voiceService.getDataByLang(uslang);
      selectedDictReference_(null);
      lstDictsReference = await res1;
      selectedDictNote_(null);
      lstDictsNote = await res2;
      selectedDictTranslation_(null);
      lstDictsTranslation = await res3;
      selectedTextbook_(null);
      lstTextbooks = await res4;
      lstTextbookFilters =
          lstTextbooks.map((o) => MSelectItem(o.id, o.textbookname)).toList();
      lstTextbookFilters.insert(0, MSelectItem(0, "All Textbooks"));
      lstOnlineTextbookFilters = lstTextbooks
          .where((o) => o.online == 1)
          .map((o) => MSelectItem(o.id, o.textbookname))
          .toList();
      lstOnlineTextbookFilters.insert(0, MSelectItem(0, "All Textbooks"));
      lstAutoCorrect = await res5;
      selectedVoice_(null);
      lstVoices = await res6;
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
      selectedDictReference_(lstDictsReference.firstWhereOrNull(
              (o) => o.dictid.toString() == usdictreference) ??
          lstDictsReference.firstWhereOrNull((_) => true));
      selectedDictNote_(
          lstDictsNote.firstWhereOrNull((o) => o.dictid == usdictnote) ??
              lstDictsNote.firstWhereOrNull((_) => true));
      selectedDictTranslation_(lstDictsTranslation
              .firstWhereOrNull((o) => o.dictid == usdicttranslation) ??
          lstDictsTranslation.firstWhereOrNull((_) => true));
      selectedTextbook_(
          lstTextbooks.firstWhereOrNull((o) => o.id == ustextbook) ??
              lstTextbooks.firstWhereOrNull((_) => true));
      selectedVoice_(lstVoices.firstWhereOrNull((o) => o.id == usvoice) ??
          lstVoices.firstWhereOrNull((_) => true));
      if (dirty) await _userSettingService.updateByInt(INFO_USLANG, uslang);
    });
    selectedLang_ = Command.createSync((MLanguage? v) {
      selectedLang = v;
    }, initialValue: null);
    selectedLang_.listen((v, _) => updateLang());

    updateVoice = Command.createAsyncNoParamNoResult(() async {
      if (selectedVoice == null) return;
      final newVal = selectedVoice!.id;
      final dirty = usvoice != newVal;
      usvoice = newVal;
      flutterTts.setVoice({
        "name": selectedVoice!.voicename,
        "locale": selectedVoice!.voicelang
      });
      if (dirty) await _userSettingService.updateByInt(INFO_USVOICE, usvoice);
    });
    selectedVoice_ = Command.createSync((MVoice? v) {
      selectedVoice = v;
    }, initialValue: null);
    selectedVoice_.listen((v, _) => updateVoice());

    updateTextbook = Command.createAsyncNoParamNoResult(() async {
      if (selectedTextbook == null) return;
      final newVal = selectedTextbook!.id;
      final dirty = ustextbook != newVal;
      ustextbook = newVal;
      INFO_USUNITFROM = _getUSInfo(MUSMapping.NAME_USUNITFROM);
      INFO_USPARTFROM = _getUSInfo(MUSMapping.NAME_USPARTFROM);
      INFO_USUNITTO = _getUSInfo(MUSMapping.NAME_USUNITTO);
      INFO_USPARTTO = _getUSInfo(MUSMapping.NAME_USPARTTO);
      selectedUnitFrom(usunitfrom);
      selectedPartFrom(uspartfrom);
      selectedUnitTo(usunitto);
      selectedPartTo(uspartto);
      toType_(isSingleUnit
          ? UnitPartToType.Unit
          : isSingleUnitPart
              ? UnitPartToType.Part
              : UnitPartToType.To);
      if (dirty) {
        await _userSettingService.updateByInt(INFO_USTEXTBOOK, ustextbook);
      }
    });
    selectedTextbook_ = Command.createSync((MTextbook? v) {
      selectedTextbook = v;
    }, initialValue: null);
    selectedTextbook_.listen((v, _) => updateTextbook());

    updateDictReference = Command.createAsyncNoParamNoResult(() async {
      if (selectedDictReference == null) return;
      final newVal = selectedDictReference!.dictid.toString();
      final dirty = usdictreference != newVal;
      usdictreference = newVal;
      if (dirty) {
        await _userSettingService.updateByString(
            INFO_USDICTREFERENCE, usdictreference);
      }
    });
    selectedDictReference_ = Command.createSync((MDictionary? v) {
      selectedDictReference = v;
    }, initialValue: null);
    selectedDictReference_.listen((v, _) => updateDictReference());

    updateDictNote = Command.createAsyncNoParamNoResult(() async {
      if (selectedDictNote == null) return;
      final newVal = selectedDictNote!.dictid;
      final dirty = usdictnote != newVal;
      usdictnote = newVal;
      if (dirty) {
        await _userSettingService.updateByInt(INFO_USDICTNOTE, usdictnote);
      }
    });
    selectedDictNote_ = Command.createSync((MDictionary? v) {
      selectedDictNote = v;
    }, initialValue: null);
    selectedDictNote_.listen((v, _) => updateDictNote());

    updateDictTranslation = Command.createAsyncNoParamNoResult(() async {
      if (selectedDictTranslation == null) return;
      final newVal = selectedDictTranslation!.dictid;
      final dirty = usdicttranslation != newVal;
      usdicttranslation = newVal;
      if (dirty) {
        await _userSettingService.updateByInt(
            INFO_USDICTTRANSLATION, usdicttranslation);
      }
    });
    selectedDictTranslation_ = Command.createSync((MDictionary? v) {
      selectedDictTranslation = v;
    }, initialValue: null);
    selectedDictTranslation_.listen((v, _) => updateDictTranslation());

    updateUnitFrom = Command.createAsyncNoParamNoResult(() async {
      await _doUpdateUnitFrom(usunitfrom);
      if (toType == UnitPartToType.Unit) {
        await _doUpdateSingleUnit();
      } else if (toType == UnitPartToType.Part || isInvaidUnitPart) {
        await _doUpdateUnitPartTo();
      }
    });
    selectedUnitFrom = Command.createSync((int? v) {
      usunitfrom = v!;
    }, initialValue: null);
    selectedUnitFrom.listen((v, _) => updateUnitFrom());

    updatePartFrom = Command.createAsyncNoParamNoResult(() async {
      await _doUpdatePartFrom(uspartfrom);
      if (toType == UnitPartToType.Part || isInvaidUnitPart) {
        await _doUpdateUnitPartTo();
      }
    });
    selectedPartFrom = Command.createSync((int? v) {
      uspartfrom = v!;
    }, initialValue: null);
    selectedPartFrom.listen((v, _) => updatePartFrom());

    updateUnitTo = Command.createAsyncNoParamNoResult(() async {
      await _doUpdateUnitTo(usunitto);
      if (isInvaidUnitPart) await _doUpdateUnitPartFrom();
    });
    selectedUnitTo = Command.createSync((int? v) {
      usunitto = v!;
    }, initialValue: null);
    selectedUnitTo.listen((v, _) => updateUnitTo());

    updatePartTo = Command.createAsyncNoParamNoResult(() async {
      await _doUpdatePartTo(uspartto);
      if (isInvaidUnitPart) await _doUpdateUnitPartFrom();
    });
    selectedPartTo = Command.createSync((int? v) {
      uspartto = v!;
    }, initialValue: null);
    selectedPartTo.listen((v, _) => updatePartTo());

    setToType = Command.createAsyncNoParamNoResult(() async {
      final b = toType == UnitPartToType.To;
      unitToEnabled = b;
      partToEnabled = b && !isSinglePart;
      previousEnabled = !b;
      nextEnabled = !b;
      final b2 = toType != UnitPartToType.Unit;
      final t = !b2 ? "Unit" : "Part";
      previousText = "Previous $t";
      nextText = "Next $t";
      partFromEnabled = b2 && !isSinglePart;
      if (toType == UnitPartToType.Unit) {
        await _doUpdateSingleUnit();
      } else if (toType == UnitPartToType.Part) {
        await _doUpdateUnitPartTo();
      }
    });
    toType_ = Command.createSync((UnitPartToType v) {
      toType = v;
    }, initialValue: UnitPartToType.To);
    toType_.listen((v, _) => setToType());
  }

  Future<void> getData() async {
    final res1 = _languageService.getData();
    final res2 = _usMappingService.getData();
    final res3 = _userSettingService.getData();
    lstLanguages = await res1;
    lstUSMappings = await res2;
    lstUserSettings = await res3;
    INFO_USLANG = _getUSInfo(MUSMapping.NAME_USLANG);
    selectedLang_(lstLanguages.firstWhere((o) => o.id == uslang));
  }

  String autoCorrectInput(String text) => _autoCorrectService.autoCorrect(
      text, lstAutoCorrect, (o) => o.input, (o) => o.extended);

  Future<void> previousUnitPart() async {
    if (toType == UnitPartToType.Unit) {
      if (usunitfrom > 1) {
        final res1 = _doUpdateUnitFrom(usunitfrom - 1);
        final res2 = _doUpdateUnitTo(usunitfrom);
        await res1;
        await res2;
      }
    } else if (uspartfrom > 1) {
      final res1 = _doUpdatePartFrom(uspartfrom - 1);
      final res2 = _doUpdateUnitPartTo();
      await res1;
      await res2;
    } else if (usunitfrom > 1) {
      final res1 = _doUpdateUnitFrom(usunitfrom - 1);
      final res2 = _doUpdatePartFrom(partCount);
      final res3 = _doUpdateUnitPartTo();
      await res1;
      await res2;
      await res3;
    }
  }

  Future<void> nextUnitPart() async {
    if (toType == UnitPartToType.Unit) {
      if (usunitfrom < unitCount) {
        final res1 = _doUpdateUnitFrom(usunitfrom + 1);
        final res2 = _doUpdateUnitTo(usunitfrom);
        await res1;
        await res2;
      }
    } else if (uspartfrom < partCount) {
      final res1 = _doUpdatePartFrom(uspartfrom + 1);
      final res2 = _doUpdateUnitPartTo();
      await res1;
      await res2;
    } else if (usunitfrom < unitCount) {
      final res1 = _doUpdateUnitFrom(usunitfrom + 1);
      final res2 = _doUpdatePartFrom(1);
      final res3 = _doUpdateUnitPartTo();
      await res1;
      await res2;
      await res3;
    }
  }

  Future<void> _doUpdateUnitPartFrom() async {
    final res1 = _doUpdateUnitFrom(usunitto);
    final res2 = _doUpdatePartFrom(uspartto);
    await res1;
    await res2;
  }

  Future<void> _doUpdateUnitPartTo() async {
    final res1 = _doUpdateUnitTo(usunitfrom);
    final res2 = _doUpdatePartTo(uspartfrom);
    await res1;
    await res2;
  }

  Future<void> _doUpdateSingleUnit() async {
    final res1 = _doUpdateUnitTo(usunitfrom);
    final res2 = _doUpdatePartFrom(1);
    final res3 = _doUpdatePartTo(partCount);
    await res1;
    await res2;
    await res3;
  }

  Future<void> _doUpdateUnitFrom(int newVal) async {
    if (usunitfrom == newVal) return;
    selectedUnitFrom(newVal);
    await _userSettingService.updateByInt(INFO_USUNITFROM, usunitfrom = newVal);
  }

  Future<void> _doUpdatePartFrom(int newVal) async {
    if (uspartfrom == newVal) return;
    selectedPartFrom(newVal);
    await _userSettingService.updateByInt(INFO_USPARTFROM, uspartfrom = newVal);
  }

  Future<void> _doUpdateUnitTo(int newVal) async {
    if (usunitto == newVal) return;
    selectedUnitTo(newVal);
    await _userSettingService.updateByInt(INFO_USUNITTO, usunitto = newVal);
  }

  Future<void> _doUpdatePartTo(int newVal) async {
    if (uspartto == newVal) return;
    selectedPartTo(newVal);
    await _userSettingService.updateByInt(INFO_USPARTTO, uspartto = newVal);
  }

  static const ZeroNote = "O";

  Future<String> getNote(String word) async {
    if (selectedDictNote == null) return "";
    var url = selectedDictNote!.urlString(word, lstAutoCorrect);
    var html = await BaseService.getHtmlByUrl(url);
    return HtmlTransformService.extractTextFromHtml(
        html, selectedDictNote!.transform, "", (text, _) => text);
  }

  Future<void> getNotes(int wordCount, bool Function(int) isNoteEmpty,
      Future<void> Function(int) getOne) async {
    if (selectedDictNote == null) return;
    for (int i = 0;;) {
      await Future.delayed(Duration(milliseconds: selectedDictNote!.wait));
      while (i < wordCount && !isNoteEmpty(i)) {
        i++;
      }
      if (i > wordCount) break;
      if (i < wordCount) await getOne(i);
      i++;
    }
  }

  Future<void> clearNotes(int wordCount, bool Function(int) isNoteEmpty,
      Future<void> Function(int) getOne) async {
    if (selectedDictNote == null) return;
    for (int i = 0; i < wordCount;) {
      while (i < wordCount && !isNoteEmpty(i)) {
        i++;
      }
      if (i < wordCount) await getOne(i);
      i++;
    }
  }

  Future<String> getBlogContent(int unit) async {
    final item = await _unitBlogPostService.getDataByTextbook(
        selectedTextbook!.id, unit);
    return item?.content ?? "";
  }

  Future<void> saveBlogContent(String content) async =>
      await _unitBlogPostService.update(
          selectedTextbook!.id, usunitto, content);
}
