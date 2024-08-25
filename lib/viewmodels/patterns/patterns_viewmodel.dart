import 'package:lolly_flutter/main.dart';
import 'package:lolly_flutter/models/wpp/mpattern.dart';
import 'package:lolly_flutter/services/wpp/pattern_service.dart';
import 'package:lolly_flutter/viewmodels/misc/settings_viewmodel.dart';
import 'package:rx_command/rx_command.dart';
import 'package:rxdart/rxdart.dart';

class PatternsViewModel {
  List<MPattern> lstPatternsAll = [], lstPatterns = [];
  final patternService = PatternService();
  var reloaded = false;
  late RxCommand<void, List<MPattern>> reloadCommand;
  final textFilter_ =
      RxCommand.createSync((String s) => s, initialLastResult: "");
  String get textFilter => textFilter_.lastResult!;
  final scopeFilter_ = RxCommand.createSync((String s) => s,
      initialLastResult: SettingsViewModel.scopePatternFilters[0]);
  String get scopeFilter => scopeFilter_.lastResult!;

  PatternsViewModel() {
    reloadCommand = RxCommand.createAsyncNoParam(() async {
      if (!reloaded) {
        lstPatternsAll =
            await patternService.getDataByLang(vmSettings.selectedLang!.id);
        reloaded = true;
      }
      lstPatterns = textFilter.isEmpty
          ? lstPatternsAll
          : lstPatternsAll
              .where((o) => (scopeFilter == "Pattern" ? o.pattern : o.tags)
                  .toLowerCase()
                  .contains(textFilter.toLowerCase()))
              .toList();
      return lstPatterns;
    });
    textFilter_
        .debounceTime(const Duration(milliseconds: 500))
        .listen(reloadCommand.call);
    scopeFilter_.listen(reloadCommand.call);
  }

  MPattern newPattern() => MPattern()..langid = vmSettings.selectedLang!.id;
}
