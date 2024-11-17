import 'package:flutter_command/flutter_command.dart';
import 'package:lolly_flutter/main.dart';
import 'package:lolly_flutter/models/wpp/munitphrase.dart';
import 'package:lolly_flutter/services/wpp/unit_phrase_service.dart';
import 'package:lolly_flutter/viewmodels/misc/settings_viewmodel.dart';

class PhrasesUnitViewModel {
  bool inbook;
  List<MUnitPhrase> lstUnitPhrasesAll = [], lstUnitPhrases = [];
  final unitPhraseService = UnitPhraseService();
  var reloaded = false;
  late Command<void, List<MUnitPhrase>> reloadCommand;
  final textFilter_ = Command.createSync((String s) => s, initialValue: "");
  String get textFilter => textFilter_.value;
  final scopeFilter_ = Command.createSync((String s) => s,
      initialValue: SettingsViewModel.scopePhraseFilters[0]);
  String get scopeFilter => scopeFilter_.value;
  final textbookFilter_ = Command.createSync((int v) => v, initialValue: 0);
  int get textbookFilter => textbookFilter_.value;

  PhrasesUnitViewModel(this.inbook) {
    reloadCommand = Command.createAsyncNoParam(() async {
      if (!reloaded) {
        lstUnitPhrasesAll = inbook
            ? await unitPhraseService.getDataByTextbookUnitPart(
                vmSettings.selectedTextbook!,
                vmSettings.usunitpartfrom,
                vmSettings.usunitpartto)
            : await unitPhraseService.getDataByLang(
                vmSettings.selectedLang!.id, vmSettings.lstTextbooks);
        reloaded = true;
      }
      _applyFilters();
      return lstUnitPhrases;
    }, initialValue: []);
    textFilter_
        .debounce(const Duration(milliseconds: 500))
        .listen((v, _) => reloadCommand());
    scopeFilter_.listen((v, _) => reloadCommand());
    textbookFilter_.listen((v, _) => reloadCommand());
  }

  void _applyFilters() => lstUnitPhrases = textFilter.isEmpty &&
          textbookFilter == 0
      ? lstUnitPhrasesAll
      : lstUnitPhrasesAll
          .where((o) => (scopeFilter == "Phrase" ? o.phrase : o.translation)
              .toLowerCase()
              .contains(textFilter.toLowerCase()))
          .where((o) => textbookFilter == 0 || o.textbookid == textbookFilter)
          .toList();

  MUnitPhrase newUnitPhrase() {
    int f(MUnitPhrase o) => o.unit * 10000 + o.part * 1000 + o.seqnum;
    final maxElem = lstUnitPhrases.isEmpty
        ? null
        : lstUnitPhrases.reduce((acc, v) => f(acc) < f(v) ? v : acc);
    return MUnitPhrase()
      ..langid = vmSettings.selectedLang!.id
      ..textbookid = vmSettings.ustextbook
      ..unit = maxElem?.unit ?? vmSettings.usunitto
      ..part = maxElem?.part ?? vmSettings.uspartto
      ..seqnum = (maxElem?.seqnum ?? 0) + 1
      ..textbook = vmSettings.selectedTextbook;
  }

  Future<void> update(MUnitPhrase item) async {
    await unitPhraseService.update(item);
    var o =
        await unitPhraseService.getDataById(item.id, vmSettings.lstTextbooks);
    if (o != null) item.copyFrom(o);
  }

  Future<void> create(MUnitPhrase item) async {
    await unitPhraseService.create(item);
    var o =
        await unitPhraseService.getDataById(item.id, vmSettings.lstTextbooks);
    if (o != null) item.copyFrom(o);
    lstUnitPhrasesAll.add(item);
    _applyFilters();
  }
}
