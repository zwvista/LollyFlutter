import 'package:lolly_flutter/main.dart';
import 'package:lolly_flutter/models/wpp/mlangphrase.dart';
import 'package:lolly_flutter/services/wpp/lang_phrase_service.dart';
import 'package:lolly_flutter/viewmodels/misc/settings_viewmodel.dart';
import 'package:rx_command/rx_command.dart';
import 'package:rxdart/rxdart.dart';

class PhrasesLangViewModel {
  List<MLangPhrase> lstLangPhrasesAll, lstLangPhrases;
  final langPhraseService = LangPhraseService();
  RxCommand<void, List<MLangPhrase>> reloadCommand, filterCommand;
  RxCommand<String, String> textFilterChangedCommand, scopeFilterChangedCommand;
  var textFilter = "";
  var scopeFilter = SettingsViewModel.scopePhraseFilters[0];

  PhrasesLangViewModel() {
    reloadCommand = RxCommand.createAsyncNoParam<List<MLangPhrase>>(() async =>
        lstLangPhrasesAll =
            await langPhraseService.getDataByLang(vmSettings.selectedLang.id));
    filterCommand = RxCommand.createSyncNoParam(() => lstLangPhrases =
        textFilter.isEmpty
            ? lstLangPhrasesAll
            : lstLangPhrasesAll
                .where((o) =>
                    scopeFilter.isNotEmpty ||
                    (scopeFilter == "Phrase" ? o.phrase : o.translation)
                        .toLowerCase()
                        .contains(textFilter.toLowerCase()))
                .toList());
    reloadCommand.listen(filterCommand);
    textFilterChangedCommand = RxCommand.createSync<String, String>((s) => s);
    textFilterChangedCommand
        .debounceTime(Duration(milliseconds: 500))
        .listen(reloadCommand);
    scopeFilterChangedCommand = RxCommand.createSync((s) => scopeFilter = s);
    scopeFilterChangedCommand.listen(filterCommand);
    reloadCommand.execute();
  }

  MLangPhrase newLangPhrase() =>
      MLangPhrase()..langid = vmSettings.selectedLang.id;
}
