import 'package:flutter_command/flutter_command.dart';
import 'package:lolly_flutter/main.dart';
import 'package:lolly_flutter/models/wpp/mlangword.dart';
import 'package:lolly_flutter/services/wpp/lang_word_service.dart';

import '../misc/settings_viewmodel.dart';

class WordsLangViewModel {
  List<MLangWord> lstLangWordsAll = [], lstLangWords = [];
  final langWordService = LangWordService();
  var reloaded = false;
  late Command<void, List<MLangWord>> reloadCommand;
  final textFilter_ = Command.createSync((String s) => s, initialValue: "");
  String get textFilter => textFilter_.value;
  final scopeFilter_ = Command.createSync((String s) => s,
      initialValue: SettingsViewModel.scopeWordFilters[0]);
  String get scopeFilter => scopeFilter_.value;

  WordsLangViewModel() {
    reloadCommand = Command.createAsyncNoParam<List<MLangWord>>(() async {
      if (!reloaded) {
        lstLangWordsAll =
            await langWordService.getDataByLang(vmSettings.selectedLang!.id);
        reloaded = true;
      }
      _applyFilters();
      return lstLangWords;
    }, initialValue: []);
    textFilter_
        .debounce(const Duration(milliseconds: 500))
        .listen((v, _) => reloadCommand());
    scopeFilter_.listen((v, _) => reloadCommand());
  }

  void _applyFilters() => lstLangWords = textFilter.isEmpty
      ? lstLangWordsAll
      : lstLangWordsAll
          .where((o) => (scopeFilter == "Word" ? o.word : o.note)
              .toLowerCase()
              .contains(textFilter.toLowerCase()))
          .toList();

  MLangWord newLangWord() => MLangWord()..langid = vmSettings.selectedLang!.id;

  Future<void> update(MLangWord item) async {
    await langWordService.update(item);
  }

  Future<void> create(MLangWord item) async {
    item.id = await langWordService.create(item);
    lstLangWordsAll.add(item);
    _applyFilters();
  }

  Future<void> getNote(MLangWord item) async {
    item.note = await vmSettings.getNote(item.word);
    await langWordService.updateNote(item.id, item.note);
  }

  Future<void> clearNote(MLangWord item) async {
    item.note = SettingsViewModel.ZeroNote;
    await langWordService.updateNote(item.id, item.note);
  }
}
