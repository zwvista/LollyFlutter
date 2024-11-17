import 'package:flutter_command/flutter_command.dart';
import 'package:lolly_flutter/main.dart';
import 'package:lolly_flutter/models/wpp/munitword.dart';
import 'package:lolly_flutter/services/wpp/unit_word_service.dart';

import '../misc/settings_viewmodel.dart';

class WordsUnitViewModel {
  bool inbook;
  List<MUnitWord> lstUnitWordsAll = [], lstUnitWords = [];
  final unitWordService = UnitWordService();
  var reloaded = false;
  late Command<void, List<MUnitWord>> reloadCommand;
  final textFilter_ = Command.createSync((String s) => s, initialValue: "");
  String get textFilter => textFilter_.value;
  final scopeFilter_ = Command.createSync((String s) => s,
      initialValue: SettingsViewModel.scopeWordFilters[0]);
  String get scopeFilter => scopeFilter_.value;
  final textbookFilter_ = Command.createSync((int v) => v, initialValue: 0);
  int get textbookFilter => textbookFilter_.value;

  WordsUnitViewModel(this.inbook) {
    reloadCommand = Command.createAsyncNoParam(() async {
      if (!reloaded) {
        lstUnitWordsAll = inbook
            ? await unitWordService.getDataByTextbookUnitPart(
                vmSettings.selectedTextbook!,
                vmSettings.usunitpartfrom,
                vmSettings.usunitpartto)
            : await unitWordService.getDataByLang(
                vmSettings.selectedLang!.id, vmSettings.lstTextbooks);
        reloaded = true;
      }
      _applyFilters();
      return lstUnitWords;
    }, initialValue: []);
    textFilter_
        .debounce(const Duration(milliseconds: 500))
        .listen((v, _) => reloadCommand());
    scopeFilter_.listen((v, _) => reloadCommand());
    textbookFilter_.listen((v, _) => reloadCommand());
  }

  void _applyFilters() => lstUnitWords = textFilter.isEmpty &&
          textbookFilter == 0
      ? lstUnitWordsAll
      : lstUnitWordsAll
          .where((o) => (scopeFilter == "Word" ? o.word : o.note)
              .toLowerCase()
              .contains(textFilter.toLowerCase()))
          .where((o) => textbookFilter == 0 || o.textbookid == textbookFilter)
          .toList();

  MUnitWord newUnitWord() {
    int f(MUnitWord o) => o.unit * 10000 + o.part * 1000 + o.seqnum;
    final maxElem = lstUnitWords.isEmpty
        ? null
        : lstUnitWords.reduce((acc, v) => f(acc) < f(v) ? v : acc);
    return MUnitWord()
      ..langid = vmSettings.selectedLang!.id
      ..textbookid = vmSettings.ustextbook
      ..unit = maxElem?.unit ?? vmSettings.usunitto
      ..part = maxElem?.part ?? vmSettings.uspartto
      ..seqnum = (maxElem?.seqnum ?? 0) + 1
      ..textbook = vmSettings.selectedTextbook;
  }

  Future<void> update(MUnitWord item) async {
    await unitWordService.update(item);
    var o = await unitWordService.getDataById(item.id, vmSettings.lstTextbooks);
    if (o != null) item.copyFrom(o);
  }

  Future<void> create(MUnitWord item) async {
    await unitWordService.create(item);
    var o = await unitWordService.getDataById(item.id, vmSettings.lstTextbooks);
    if (o != null) item.copyFrom(o);
    lstUnitWordsAll.add(item);
    _applyFilters();
  }

  Future<void> getNote(MUnitWord item) async {
    item.note = await vmSettings.getNote(item.word);
    await unitWordService.updateNote(item.wordid, item.note);
  }

  Future<void> clearNote(MUnitWord item) async {
    item.note = SettingsViewModel.ZeroNote;
    await unitWordService.updateNote(item.wordid, item.note);
  }

  Future<void> getNotes(bool ifEmpty, Function(int) oneComplete) async {
    await vmSettings.getNotes(
        lstUnitWords.length, (i) => !ifEmpty || lstUnitWords[i].note.isEmpty,
        (i) async {
      await getNote(lstUnitWords[i]);
      oneComplete(i);
    });
  }

  Future<void> clearNotes(bool ifEmpty, Function(int) oneComplete) async {
    await vmSettings.clearNotes(
        lstUnitWords.length, (i) => !ifEmpty || lstUnitWords[i].note.isEmpty,
        (i) async {
      await clearNote(lstUnitWords[i]);
      oneComplete(i);
    });
  }
}
