import 'package:flutter_command/flutter_command.dart';
import 'package:lolly_flutter/main.dart';
import 'package:lolly_flutter/models/wpp/mpattern.dart';
import 'package:lolly_flutter/services/wpp/pattern_service.dart';
import 'package:lolly_flutter/viewmodels/misc/settings_viewmodel.dart';

class PatternsViewModel {
  List<MPattern> lstPatternsAll = [], lstPatterns = [];
  final patternService = PatternService();
  var reloaded = false;
  late Command<void, List<MPattern>> reloadCommand;
  final textFilter_ = Command.createSync((String s) => s, initialValue: "");
  String get textFilter => textFilter_.value;
  final scopeFilter_ = Command.createSync((String s) => s,
      initialValue: SettingsViewModel.scopePatternFilters[0]);
  String get scopeFilter => scopeFilter_.value;

  PatternsViewModel() {
    reloadCommand = Command.createAsyncNoParam(() async {
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
    }, initialValue: []);
    textFilter_
        .debounce(const Duration(milliseconds: 500))
        .listen((v, _) => reloadCommand());
    scopeFilter_.listen((v, _) => reloadCommand());
  }

  MPattern newPattern() => MPattern()..langid = vmSettings.selectedLang!.id;
}
