import 'package:lolly_flutter/main.dart';
import 'package:lolly_flutter/models/wpp/mlangphrase.dart';
import 'package:lolly_flutter/services/wpp/lang_phrase_service.dart';
import 'package:lolly_flutter/viewmodels/misc/settings_viewmodel.dart';
import 'package:rx_command/rx_command.dart';
import 'package:rxdart/rxdart.dart';

class PhrasesLangViewModel {
  List<MLangPhrase> lstLangPhrasesAll, lstLangPhrases;
  final langPhraseService = LangPhraseService();
  var _reloaded = false;
  RxCommand<void, List<MLangPhrase>> reloadCommand;
  final textFilter =
      RxCommand.createSync((String s) => s, initialLastResult: "");
  final scopeFilter = RxCommand.createSync((String s) => s,
      initialLastResult: SettingsViewModel.scopeWordFilters[0]);

  PhrasesLangViewModel() {
    reloadCommand = RxCommand.createAsyncNoParam(() async {
      if (!_reloaded) {
        lstLangPhrasesAll =
            await langPhraseService.getDataByLang(vmSettings.selectedLang.id);
        _reloaded = true;
      }
      _applyFilters();
      return lstLangPhrases;
    });
    textFilter.debounceTime(Duration(milliseconds: 500)).listen(reloadCommand);
    scopeFilter.listen(reloadCommand);
    reloadCommand();
  }

  void _applyFilters() => lstLangPhrases = textFilter.lastResult.isEmpty
      ? lstLangPhrasesAll
      : lstLangPhrasesAll
          .where((o) =>
              (scopeFilter.lastResult == "Phrase" ? o.phrase : o.translation)
                  .toLowerCase()
                  .contains(textFilter.lastResult.toLowerCase()))
          .toList();

  MLangPhrase newLangPhrase() =>
      MLangPhrase()..langid = vmSettings.selectedLang.id;

  Future update(MLangPhrase item) async {
    await langPhraseService.update(item);
  }

  Future create(MLangPhrase item) async {
    item.id = await langPhraseService.create(item);
    lstLangPhrasesAll.add(item);
    _applyFilters();
  }
}
