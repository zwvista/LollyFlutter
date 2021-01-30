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
  final textFilter =
      RxCommand.createSync((String s) => s, initialLastResult: "");
  final scopeFilter = RxCommand.createSync((String s) => s,
      initialLastResult: SettingsViewModel.scopeWordFilters[0]);

  PhrasesLangViewModel() {
    reloadCommand = RxCommand.createAsyncNoParam<List<MLangPhrase>>(() async =>
        lstLangPhrasesAll =
            await langPhraseService.getDataByLang(vmSettings.selectedLang.id));
    filterCommand = RxCommand.createSyncNoParam(() => lstLangPhrases =
        textFilter.lastResult.isEmpty
            ? lstLangPhrasesAll
            : lstLangPhrasesAll
                .where((o) => (scopeFilter.lastResult == "Phrase"
                        ? o.phrase
                        : o.translation)
                    .toLowerCase()
                    .contains(textFilter.lastResult.toLowerCase()))
                .toList());
    reloadCommand.listen(filterCommand);
    textFilter.debounceTime(Duration(milliseconds: 500)).listen(filterCommand);
    scopeFilter.listen(filterCommand);
    reloadCommand.execute();
  }

  MLangPhrase newLangPhrase() =>
      MLangPhrase()..langid = vmSettings.selectedLang.id;
}
