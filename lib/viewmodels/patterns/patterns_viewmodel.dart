import 'package:lolly_flutter/main.dart';
import 'package:lolly_flutter/models/wpp/mpattern.dart';
import 'package:lolly_flutter/services/wpp/pattern_service.dart';
import 'package:lolly_flutter/viewmodels/misc/settings_viewmodel.dart';
import 'package:rx_command/rx_command.dart';
import 'package:rxdart/rxdart.dart';

class PatternsViewModel {
  List<MPattern> lstPatternsAll, lstPatterns;
  final patternService = PatternService();
  RxCommand<void, List<MPattern>> reloadCommand, filterCommand;
  RxCommand<String, String> textFilterChangedCommand, scopeFilterChangedCommand;
  var textFilter = "";
  var scopeFilter = SettingsViewModel.scopePatternFilters[0];

  PatternsViewModel() {
    reloadCommand = RxCommand.createAsyncNoParam(() async => lstPatternsAll =
        await patternService.getDataByLang(vmSettings.selectedLang.id));
    filterCommand =
        RxCommand.createSyncNoParam(() => lstPatterns = textFilter.isEmpty
            ? lstPatternsAll
            : lstPatternsAll
                .where((o) =>
                    scopeFilter.isNotEmpty ||
                    (scopeFilter == "Pattern"
                            ? o.pattern
                            : scopeFilter == "Note"
                                ? o.note
                                : o.tags)
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
