import 'package:lolly_flutter/main.dart';
import 'package:lolly_flutter/models/wpp/munitword.dart';
import 'package:lolly_flutter/services/wpp/unitwordservice.dart';
import 'package:rx_command/rx_command.dart';
import 'package:rxdart/rxdart.dart';

import '../misc/settingsviewmodel.dart';

class WordsUnitViewModel {
  bool inbook;
  List<MUnitWord> lstUnitWordsAll, lstUnitWords;
  final unitWordService = UnitWordService();
  RxCommand<void, List<MUnitWord>> reloadCommand, filterCommand;
  RxCommand<String, String> textFilterChangedCommand, scopeFilterChangedCommand;
  var textFilter = "";
  var scopeFilter = SettingsViewModel.scopeWordFilters[0];

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
    filterCommand = RxCommand.createSyncNoParam(() => lstUnitWords =
        textFilter.isEmpty
            ? lstUnitWordsAll
            : lstUnitWordsAll
                .where((o) => (scopeFilter == "Word" ? o.word : o.note)
                    .toLowerCase()
                    .contains(textFilter.toLowerCase()))
                .toList());
    reloadCommand.listen(filterCommand);
    textFilterChangedCommand = RxCommand.createSync((s) => textFilter = s);
    textFilterChangedCommand
        .debounceTime(Duration(milliseconds: 500))
        .listen(filterCommand);
    scopeFilterChangedCommand = RxCommand.createSync((s) => scopeFilter = s);
    scopeFilterChangedCommand.listen(filterCommand);
    reloadCommand.execute();
  }
}
