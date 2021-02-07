import 'package:lolly_flutter/main.dart';
import 'package:lolly_flutter/models/wpp/mlangword.dart';
import 'package:lolly_flutter/services/wpp/lang_word_service.dart';
import 'package:rx_command/rx_command.dart';
import 'package:rxdart/rxdart.dart';

import '../misc/settings_viewmodel.dart';

class WordsLangViewModel {
  List<MLangWord> lstLangWordsAll, lstLangWords;
  final langWordService = LangWordService();
  var _reloaded = false;
  RxCommand<void, List<MLangWord>> reloadCommand;
  final textFilter =
      RxCommand.createSync((String s) => s, initialLastResult: "");
  final scopeFilter = RxCommand.createSync((String s) => s,
      initialLastResult: SettingsViewModel.scopeWordFilters[0]);

  WordsLangViewModel() {
    reloadCommand = RxCommand.createAsyncNoParam<List<MLangWord>>(() async {
      if (!_reloaded) {
        lstLangWordsAll =
            await langWordService.getDataByLang(vmSettings.selectedLang.id);
        _reloaded = true;
      }
      _applyFilters();
      return lstLangWords;
    });
    textFilter.debounceTime(Duration(milliseconds: 500)).listen(reloadCommand);
    scopeFilter.listen(reloadCommand);
    reloadCommand();
  }

  void _applyFilters() => lstLangWords = textFilter.lastResult.isEmpty
      ? lstLangWordsAll
      : lstLangWordsAll
          .where((o) => (scopeFilter.lastResult == "Word" ? o.word : o.note)
              .toLowerCase()
              .contains(textFilter.lastResult.toLowerCase()))
          .toList();

  MLangWord newLangWord() => MLangWord()..langid = vmSettings.selectedLang.id;

  Future update(MLangWord item) async {
    await langWordService.update(item);
  }

  Future create(MLangWord item) async {
    item.id = await langWordService.create(item);
    lstLangWordsAll.add(item);
    _applyFilters();
  }
}
