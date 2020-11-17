import 'package:lolly_flutter/main.dart';
import 'package:lolly_flutter/models/wpp/munitword.dart';
import 'package:lolly_flutter/services/wpp/unitwordservice.dart';
import 'package:rx_command/rx_command.dart';
import 'package:rxdart/rxdart.dart';

import '../settingsviewmodel.dart';

class WordsTextbookViewModel {
  bool inbook;
  List<MUnitWord> lstUnitWords;
  final unitWordService = UnitWordService();
  RxCommand<void, List<MUnitWord>> reloadCommand;
  RxCommand<String, String> textChangedCommand;
  var textFilter = "";
  var scopeFilter = SettingsViewModel.scopeWordFilters[0];

  WordsTextbookViewModel(bool inbook) {
    this.inbook = inbook;
    reloadCommand = RxCommand.createAsyncNoParam<List<MUnitWord>>(reload);
    // When the user starts typing
    textChangedCommand = RxCommand.createSync<String, String>((s) => s);
    textChangedCommand
        // Wait for the user to stop typing for 500ms
        .debounceTime(Duration(milliseconds: 500))
        // Then call the updateWeatherCommand
        .listen(reloadCommand);
    reloadCommand.execute();
  }

  Future<List<MUnitWord>> reload() async => inbook
      ? await unitWordService.getDataByTextbookUnitPart(
          vmSettings.selectedTextbook,
          vmSettings.usunitpartfrom,
          vmSettings.usunitpartto)
      : await unitWordService.getDataByLang(
          vmSettings.selectedLang.id, vmSettings.lstTextbooks);
}
