import 'package:lolly_flutter/main.dart';
import 'package:lolly_flutter/models/wpp/munitword.dart';
import 'package:lolly_flutter/services/wpp/unit_word_service.dart';
import 'package:rx_command/rx_command.dart';
import 'package:rxdart/rxdart.dart';

import '../misc/settings_viewmodel.dart';

class WordsUnitViewModel {
  bool inbook;
  List<MUnitWord> lstUnitWordsAll, lstUnitWords;
  final unitWordService = UnitWordService();
  RxCommand<void, List<MUnitWord>> reloadCommand, filterCommand;
  RxCommand<String, String> textFilterChangedCommand, scopeFilterChangedCommand;
  RxCommand<int, int> textbookFilterChangedCommand;
  var textFilter = "";
  var scopeFilter = SettingsViewModel.scopeWordFilters[0];
  var textbookFilter = 0;

  WordsUnitViewModel(bool inbook) {
    this.inbook = inbook;
    reloadCommand = RxCommand.createAsyncNoParam(() async => lstUnitWordsAll =
        inbook
            ? await unitWordService.getDataByTextbookUnitPart(
                vmSettings.selectedTextbook,
                vmSettings.usunitpartfrom,
                vmSettings.usunitpartto)
            : await unitWordService.getDataByLang(
                vmSettings.selectedLang.id, vmSettings.lstTextbooks));
    filterCommand = RxCommand.createSyncNoParam(() => lstUnitWords = textFilter
                .isEmpty &&
            textbookFilter == 0
        ? lstUnitWordsAll
        : lstUnitWordsAll
            .where((o) =>
                scopeFilter.isNotEmpty ||
                (scopeFilter == "Word" ? o.word : o.note)
                    .toLowerCase()
                    .contains(textFilter.toLowerCase()))
            .where((o) => textbookFilter == 0 || o.textbookid == textbookFilter)
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
