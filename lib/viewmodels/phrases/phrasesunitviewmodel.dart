import 'package:lolly_flutter/main.dart';
import 'package:lolly_flutter/models/wpp/munitphrase.dart';
import 'package:lolly_flutter/services/wpp/unitphraseservice.dart';
import 'package:lolly_flutter/viewmodels/misc/settingsviewmodel.dart';
import 'package:rx_command/rx_command.dart';
import 'package:rxdart/rxdart.dart';

class PhrasesUnitViewModel {
  bool inbook;
  List<MUnitPhrase> lstUnitPhrasesAll, lstUnitPhrases;
  final unitPhraseService = UnitPhraseService();
  RxCommand<void, List<MUnitPhrase>> reloadCommand, filterCommand;
  RxCommand<String, String> textFilterChangedCommand, scopeFilterChangedCommand;
  RxCommand<int, int> textbookFilterChangedCommand;
  var textFilter = "";
  var scopeFilter = SettingsViewModel.scopePhraseFilters[0];
  var textbookFilter = 0;

  PhrasesUnitViewModel(bool inbook) {
    this.inbook = inbook;
    reloadCommand = RxCommand.createAsyncNoParam(() async => lstUnitPhrasesAll =
        inbook
            ? await unitPhraseService.getDataByTextbookUnitPart(
                vmSettings.selectedTextbook,
                vmSettings.usunitpartfrom,
                vmSettings.usunitpartto)
            : await unitPhraseService.getDataByLang(
                vmSettings.selectedLang.id, vmSettings.lstTextbooks));
    filterCommand = RxCommand.createSyncNoParam(() => lstUnitPhrases =
        textFilter.isEmpty && textbookFilter == 0
            ? lstUnitPhrasesAll
            : lstUnitPhrasesAll
                .where((o) =>
                    scopeFilter.isNotEmpty ||
                    (scopeFilter == "Phrase" ? o.phrase : o.translation)
                        .toLowerCase()
                        .contains(textFilter.toLowerCase()))
                .where((o) =>
                    textbookFilter == 0 || o.textbookid == textbookFilter)
                .toList());
    reloadCommand.listen(filterCommand);
    textFilterChangedCommand = RxCommand.createSync((s) => textFilter = s);
    textFilterChangedCommand
        .debounceTime(Duration(milliseconds: 500))
        .listen(filterCommand);
    scopeFilterChangedCommand = RxCommand.createSync((s) => scopeFilter = s);
    scopeFilterChangedCommand.listen(filterCommand);
    textbookFilterChangedCommand =
        RxCommand.createSync((v) => textbookFilter = v);
    textbookFilterChangedCommand.listen(filterCommand);
    reloadCommand.execute();
  }
}
