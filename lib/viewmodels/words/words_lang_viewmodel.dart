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
  RxCommand<String, String> textFilterChangedCommand, scopeFilterChangedCommand;
  var textFilter = "";
  var scopeFilter = SettingsViewModel.scopeWordFilters[0];

  WordsLangViewModel() {
    reloadCommand = RxCommand.createAsyncNoParam<List<MLangWord>>(() async =>
        lstLangWordsAll =
            await langWordService.getDataByLang(vmSettings.selectedLang.id));
    filterCommand = RxCommand.createSyncNoParam(() => lstLangWords =
        textFilter.isEmpty
            ? lstLangWordsAll
            : lstLangWordsAll
                .where((o) =>
                    scopeFilter.isNotEmpty ||
                    (scopeFilter == "Word" ? o.word : o.note)
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

  MLangWord newLangWord() => MLangWord()..langid = vmSettings.selectedLang.id;
}
