import 'package:lolly_flutter/main.dart';
import 'package:lolly_flutter/models/wpp/munitword.dart';
import 'package:lolly_flutter/services/wpp/unit_word_service.dart';
import 'package:rx_command/rx_command.dart';
import 'package:rxdart/rxdart.dart';

import '../misc/settings_viewmodel.dart';

class WordsUnitViewModel {
  bool inbook;
  List<MUnitWord> lstUnitWordsAll = [], lstUnitWords = [];
  final unitWordService = UnitWordService();
  var reloaded = false;
  late RxCommand<void, List<MUnitWord>> reloadCommand;
  final textFilter_ =
      RxCommand.createSync((String s) => s, initialLastResult: "");
  String get textFilter => textFilter_.lastResult!;
  final scopeFilter_ = RxCommand.createSync((String s) => s,
      initialLastResult: SettingsViewModel.scopeWordFilters[0]);
  String get scopeFilter => scopeFilter_.lastResult!;
  final textbookFilter_ =
      RxCommand.createSync((int v) => v, initialLastResult: 0);
  int get textbookFilter => textbookFilter_.lastResult!;

  WordsUnitViewModel(this.inbook) {
    reloadCommand = RxCommand.createAsyncNoParam(() async {
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
    });
    textFilter_
        .debounceTime(const Duration(milliseconds: 500))
        .listen(reloadCommand.call);
    scopeFilter_.listen(reloadCommand.call);
    textbookFilter_.listen(reloadCommand.call);
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
