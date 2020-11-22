import 'package:lolly_flutter/main.dart';
import 'package:lolly_flutter/models/wpp/mlangphrase.dart';
import 'package:lolly_flutter/services/wpp/langphraseservice.dart';
import 'package:lolly_flutter/viewmodels/settingsviewmodel.dart';
import 'package:rx_command/rx_command.dart';
import 'package:rxdart/rxdart.dart';

class PhrasesLangViewModel {
  List<MLangPhrase> lstLangPhrases;
  final langPhrasesService = LangPhrasesService();
  RxCommand<void, List<MLangPhrase>> reloadCommand;
  RxCommand<String, String> textChangedCommand;
  var textFilter = "";
  var scopeFilter = SettingsViewModel.scopePhraseFilters[0];

  PhrasesLangViewModel() {
    reloadCommand = RxCommand.createAsyncNoParam<List<MLangPhrase>>(reload);
    // When the user starts typing
    textChangedCommand = RxCommand.createSync<String, String>((s) => s);
    textChangedCommand
        // Wait for the user to stop typing for 500ms
        .debounceTime(Duration(milliseconds: 500))
        // Then call the updateWeatherCommand
        .listen(reloadCommand);
    reloadCommand.execute();
  }

  Future<List<MLangPhrase>> reload() async =>
      await langPhrasesService.getDataByLang(vmSettings.selectedLang.id);
}
