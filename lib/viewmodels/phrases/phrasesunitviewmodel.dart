import 'package:lolly_flutter/main.dart';
import 'package:lolly_flutter/models/wpp/munitphrase.dart';
import 'package:lolly_flutter/services/wpp/unitphraseservice.dart';
import 'package:lolly_flutter/viewmodels/settingsviewmodel.dart';
import 'package:rx_command/rx_command.dart';
import 'package:rxdart/rxdart.dart';
import 'package:scoped_model/scoped_model.dart';

class PhrasesUnitViewModel extends Model {
  bool inbook;
  List<MUnitPhrase> lstUnitPhrases;
  final unitPhraseService = UnitPhraseService();
  RxCommand<void, List<MUnitPhrase>> reloadCommand;
  RxCommand<String, String> textChangedCommand;
  var textFilter = "";
  var scopeFilter = SettingsViewModel.scopePhraseFilters[0];

  PhrasesUnitViewModel(bool inbook) {
    this.inbook = inbook;
    reloadCommand = RxCommand.createAsyncNoParam<List<MUnitPhrase>>(reload);
    // When the user starts typing
    textChangedCommand = RxCommand.createSync<String, String>((s) => s);
    textChangedCommand
        // Wait for the user to stop typing for 500ms
        .debounceTime(Duration(milliseconds: 500))
        // Then call the updateWeatherCommand
        .listen(reloadCommand);
    reloadCommand.execute();
  }

  Future<List<MUnitPhrase>> reload() async => inbook
      ? await unitPhraseService.getDataByTextbookUnitPart(
          vmSettings.selectedTextbook,
          vmSettings.usunitpartfrom,
          vmSettings.usunitpartto)
      : await unitPhraseService.getDataByLang(
          vmSettings.selectedLang.id, vmSettings.lstTextbooks);
}
