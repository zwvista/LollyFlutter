import 'package:lolly_flutter/main.dart';
import 'package:lolly_flutter/models/wpp/munitphrase.dart';
import 'package:lolly_flutter/services/wpp/unit_phrase_service.dart';
import 'package:lolly_flutter/viewmodels/misc/settings_viewmodel.dart';
import 'package:rx_command/rx_command.dart';
import 'package:rxdart/rxdart.dart';

class PhrasesUnitViewModel {
  bool inbook;
  List<MUnitPhrase> lstUnitPhrasesAll = [], lstUnitPhrases = [];
  final unitPhraseService = UnitPhraseService();
  var reloaded = false;
  late RxCommand<void, List<MUnitPhrase>> reloadCommand;
  final textFilter_ =
      RxCommand.createSync((String s) => s, initialLastResult: "");
  String get textFilter => textFilter_.lastResult!;
  final scopeFilter_ = RxCommand.createSync((String s) => s,
      initialLastResult: SettingsViewModel.scopePhraseFilters[0]);
  String get scopeFilter => scopeFilter_.lastResult!;
  final textbookFilter_ =
      RxCommand.createSync((int v) => v, initialLastResult: 0);
  int get textbookFilter => textbookFilter_.lastResult!;

  PhrasesUnitViewModel(this.inbook) {
    reloadCommand = RxCommand.createAsyncNoParam(() async {
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
    });
    textFilter_
        .debounceTime(const Duration(milliseconds: 500))
        .listen(reloadCommand.call);
    scopeFilter_.listen(reloadCommand.call);
    textbookFilter_.listen(reloadCommand.call);
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

  Future update(MUnitPhrase item) async {
    await unitPhraseService.update(item);
    var o =
        await unitPhraseService.getDataById(item.id, vmSettings.lstTextbooks);
    if (o != null) item.copyFrom(o);
  }

  Future create(MUnitPhrase item) async {
    await unitPhraseService.create(item);
    var o =
        await unitPhraseService.getDataById(item.id, vmSettings.lstTextbooks);
    if (o != null) item.copyFrom(o);
    lstUnitPhrasesAll.add(item);
    _applyFilters();
  }
}
