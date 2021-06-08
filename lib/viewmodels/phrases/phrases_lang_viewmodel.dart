import 'package:lolly_flutter/main.dart';
import 'package:lolly_flutter/models/wpp/mlangphrase.dart';
import 'package:lolly_flutter/services/wpp/lang_phrase_service.dart';
import 'package:lolly_flutter/viewmodels/misc/settings_viewmodel.dart';
import 'package:rx_command/rx_command.dart';
import 'package:rxdart/rxdart.dart';

class PhrasesLangViewModel {
  List<MLangPhrase> lstLangPhrasesAll = [], lstLangPhrases = [];
  final langPhraseService = LangPhraseService();
  var reloaded = false;
  late RxCommand<void, List<MLangPhrase>> reloadCommand;
  final textFilter_ =
      RxCommand.createSync((String s) => s, initialLastResult: "");
  String get textFilter => textFilter_.lastResult!;
  final scopeFilter_ = RxCommand.createSync((String s) => s,
      initialLastResult: SettingsViewModel.scopePhraseFilters[0]);
  String get scopeFilter => scopeFilter_.lastResult!;

  PhrasesLangViewModel() {
    reloadCommand = RxCommand.createAsyncNoParam(() async {
      if (!reloaded) {
        lstLangPhrasesAll =
            await langPhraseService.getDataByLang(vmSettings.selectedLang!.id);
        reloaded = true;
      }
      _applyFilters();
      return lstLangPhrases;
    });
    textFilter_.debounceTime(Duration(milliseconds: 500)).listen(reloadCommand);
    scopeFilter_.listen(reloadCommand);
  }

  void _applyFilters() => lstLangPhrases = textFilter.isEmpty
      ? lstLangPhrasesAll
      : lstLangPhrasesAll
          .where((o) => (scopeFilter == "Phrase" ? o.phrase : o.translation)
              .toLowerCase()
              .contains(textFilter.toLowerCase()))
          .toList();

  MLangPhrase newLangPhrase() =>
      MLangPhrase()..langid = vmSettings.selectedLang!.id;

  Future update(MLangPhrase item) async {
    await langPhraseService.update(item);
  }

  Future create(MLangPhrase item) async {
    item.id = await langPhraseService.create(item);
    lstLangPhrasesAll.add(item);
    _applyFilters();
  }
}
