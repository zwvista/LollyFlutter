import 'package:lolly_flutter/main.dart';
import 'package:lolly_flutter/models/wpp/mlangword.dart';
import 'package:lolly_flutter/services/wpp/langwordservice.dart';
import 'package:rx_command/rx_command.dart';
import 'package:rxdart/rxdart.dart';
import '../settingsviewmodel.dart';

class WordsLangViewModel {
  List<MLangWord> lstLangWords;
  final langWordService = LangWordService();
  RxCommand<void, List<MLangWord>> reloadCommand;
  RxCommand<String, String> textChangedCommand;
  var textFilter = "";
  var scopeFilter = SettingsViewModel.scopeWordFilters[0];

  WordsLangViewModel() {
    reloadCommand = RxCommand.createAsyncNoParam<List<MLangWord>>(reload);
    // When the user starts typing
    textChangedCommand = RxCommand.createSync<String, String>((s) => s);
    textChangedCommand
        // Wait for the user to stop typing for 500ms
        .debounceTime(Duration(milliseconds: 500))
        // Then call the updateWeatherCommand
        .listen(reloadCommand);
    reloadCommand.execute();
  }

  Future<List<MLangWord>> reload() async =>
      await langWordService.getDataByLang(vmSettings.selectedLang.id);
}
