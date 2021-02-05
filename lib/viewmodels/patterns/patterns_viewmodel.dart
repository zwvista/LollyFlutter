import 'package:lolly_flutter/main.dart';
import 'package:lolly_flutter/models/wpp/mpattern.dart';
import 'package:lolly_flutter/services/wpp/pattern_service.dart';
import 'package:lolly_flutter/viewmodels/misc/settings_viewmodel.dart';
import 'package:rx_command/rx_command.dart';
import 'package:rxdart/rxdart.dart';

class PatternsViewModel {
  List<MPattern> lstPatternsAll, lstPatterns;
  final patternService = PatternService();
  var _reloaded = false;
  RxCommand<void, List<MPattern>> reloadCommand;
  final textFilter =
      RxCommand.createSync((String s) => s, initialLastResult: "");
  final scopeFilter = RxCommand.createSync((String s) => s,
      initialLastResult: SettingsViewModel.scopePatternFilters[0]);

  PatternsViewModel() {
    reloadCommand = RxCommand.createAsyncNoParam(() async {
      if (!_reloaded) {
        lstPatternsAll =
            await patternService.getDataByLang(vmSettings.selectedLang.id);
        _reloaded = true;
      }
      lstPatterns = textFilter.lastResult.isEmpty
          ? lstPatternsAll
          : lstPatternsAll
              .where((o) => (scopeFilter.lastResult == "Pattern"
                      ? o.pattern
                      : scopeFilter.lastResult == "Note"
                          ? o.note
                          : o.tags)
                  .toLowerCase()
                  .contains(textFilter.lastResult.toLowerCase()))
              .toList();
      return lstPatterns;
    });
    textFilter.debounceTime(Duration(milliseconds: 500)).listen(reloadCommand);
    scopeFilter.listen(reloadCommand);
    reloadCommand();
  }

  MPattern newPattern() => MPattern()..langid = vmSettings.selectedLang.id;
}
