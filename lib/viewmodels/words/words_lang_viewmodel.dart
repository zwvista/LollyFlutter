import 'package:lolly_flutter/main.dart';
import 'package:lolly_flutter/models/wpp/mlangword.dart';
import 'package:lolly_flutter/services/wpp/lang_word_service.dart';
import 'package:rx_command/rx_command.dart';
import 'package:rxdart/rxdart.dart';

import '../misc/settings_viewmodel.dart';

class WordsLangViewModel {
  List<MLangWord> lstLangWordsAll, lstLangWords;
  final langWordService = LangWordService();
  RxCommand<void, List<MLangWord>> reloadCommand, filterCommand;
  final textFilter =
      RxCommand.createSync((String s) => s, initialLastResult: "");
  final scopeFilter = RxCommand.createSync((String s) => s,
      initialLastResult: SettingsViewModel.scopeWordFilters[0]);

  WordsLangViewModel() {
    reloadCommand = RxCommand.createAsyncNoParam<List<MLangWord>>(() async =>
        lstLangWordsAll =
            await langWordService.getDataByLang(vmSettings.selectedLang.id));
    filterCommand = RxCommand.createSyncNoParam(() => lstLangWords = textFilter
            .lastResult.isEmpty
        ? lstLangWordsAll
        : lstLangWordsAll
            .where((o) => (scopeFilter.lastResult == "Word" ? o.word : o.note)
                .toLowerCase()
                .contains(textFilter.lastResult.toLowerCase()))
            .toList());
    reloadCommand.listen(filterCommand);
    textFilter.debounceTime(Duration(milliseconds: 500)).listen(filterCommand);
    scopeFilter.listen(filterCommand);
    reloadCommand.execute();
  }

  MLangWord newLangWord() => MLangWord()..langid = vmSettings.selectedLang.id;
}
