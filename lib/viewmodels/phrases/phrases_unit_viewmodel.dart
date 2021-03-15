import 'package:lolly_flutter/main.dart';
import 'package:lolly_flutter/models/wpp/munitphrase.dart';
import 'package:lolly_flutter/services/wpp/unit_phrase_service.dart';
import 'package:lolly_flutter/viewmodels/misc/settings_viewmodel.dart';
import 'package:rx_command/rx_command.dart';
import 'package:rxdart/rxdart.dart';

class PhrasesUnitViewModel {
  bool inbook;
  List<MUnitPhrase> lstUnitPhrasesAll, lstUnitPhrases;
  final unitPhraseService = UnitPhraseService();
  var _reloaded = false;
  RxCommand<void, List<MUnitPhrase>> reloadCommand;
  final textFilter =
      RxCommand.createSync((String s) => s, initialLastResult: "");
  final scopeFilter = RxCommand.createSync((String s) => s,
      initialLastResult: SettingsViewModel.scopePhraseFilters[0]);
  final textbookFilter =
      RxCommand.createSync((int v) => v, initialLastResult: 0);

  PhrasesUnitViewModel(this.inbook) {
    reloadCommand = RxCommand.createAsyncNoParam(() async {
      if (!_reloaded) {
        inbook
            ? await unitPhraseService.getDataByTextbookUnitPart(
                vmSettings.selectedTextbook,
                vmSettings.usunitpartfrom,
                vmSettings.usunitpartto)
            : await unitPhraseService.getDataByLang(
                vmSettings.selectedLang.id, vmSettings.lstTextbooks);
        _reloaded = true;
      }
      _applyFilters();
      return lstUnitPhrases;
    });
    textFilter.debounceTime(Duration(milliseconds: 500)).listen(reloadCommand);
    scopeFilter.listen(reloadCommand);
    textbookFilter.listen(reloadCommand);
    reloadCommand();
  }

  void _applyFilters() => lstUnitPhrases = textFilter.lastResult.isEmpty &&
          textbookFilter.lastResult == 0
      ? lstUnitPhrasesAll
      : lstUnitPhrasesAll
          .where((o) =>
              (scopeFilter.lastResult == "Phrase" ? o.phrase : o.translation)
                  .toLowerCase()
                  .contains(textFilter.lastResult.toLowerCase()))
          .where((o) =>
              textbookFilter.lastResult == 0 ||
              o.textbookid == textbookFilter.lastResult)
          .toList();

  MUnitPhrase newUnitPhrase() {
    int f(MUnitPhrase o) => o.unit * 10000 + o.part * 1000 + o.seqnum;
    final maxElem = lstUnitPhrases.reduce((acc, v) => f(acc) < f(v) ? v : acc);
    return MUnitPhrase()
      ..langid = vmSettings.selectedLang.id
      ..textbookid = vmSettings.ustextbook
      ..unit = maxElem?.unit ?? vmSettings.usunitto
      ..part = maxElem?.part ?? vmSettings.uspartto
      ..seqnum = (maxElem?.seqnum ?? 0) + 1
      ..textbook = vmSettings.selectedTextbook;
  }

  Future update(MUnitPhrase item) async {
    await unitPhraseService.update(item);
    var o =
        await unitPhraseService.getDataById(item.id, vmSettings.lstTextbooks);
    item.copyFrom(o);
  }

  Future create(MUnitPhrase item) async {
    await unitPhraseService.create(item);
    var o =
        await unitPhraseService.getDataById(item.id, vmSettings.lstTextbooks);
    item.copyFrom(o);
    lstUnitPhrasesAll.add(item);
    _applyFilters();
  }
}
