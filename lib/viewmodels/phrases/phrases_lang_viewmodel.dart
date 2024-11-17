import 'package:flutter_command/flutter_command.dart';
import 'package:lolly_flutter/main.dart';
import 'package:lolly_flutter/models/wpp/mlangphrase.dart';
import 'package:lolly_flutter/services/wpp/lang_phrase_service.dart';
import 'package:lolly_flutter/viewmodels/misc/settings_viewmodel.dart';

class PhrasesLangViewModel {
  List<MLangPhrase> lstLangPhrasesAll = [], lstLangPhrases = [];
  final langPhraseService = LangPhraseService();
  var reloaded = false;
  late Command<void, List<MLangPhrase>> reloadCommand;
  final textFilter_ = Command.createSync((String s) => s, initialValue: "");
  String get textFilter => textFilter_.value;
  final scopeFilter_ = Command.createSync((String s) => s,
      initialValue: SettingsViewModel.scopePhraseFilters[0]);
  String get scopeFilter => scopeFilter_.value;

  PhrasesLangViewModel() {
    reloadCommand = Command.createAsyncNoParam(() async {
      if (!reloaded) {
        lstLangPhrasesAll =
            await langPhraseService.getDataByLang(vmSettings.selectedLang!.id);
        reloaded = true;
      }
      _applyFilters();
      return lstLangPhrases;
    }, initialValue: []);
    textFilter_
        .debounce(const Duration(milliseconds: 500))
        .listen((v, _) => reloadCommand());
    scopeFilter_.listen((v, _) => reloadCommand());
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

  Future<void> update(MLangPhrase item) async {
    await langPhraseService.update(item);
  }

  Future<void> create(MLangPhrase item) async {
    item.id = await langPhraseService.create(item);
    lstLangPhrasesAll.add(item);
    _applyFilters();
  }
}
