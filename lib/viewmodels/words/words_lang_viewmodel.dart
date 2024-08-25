import 'package:lolly_flutter/main.dart';
import 'package:lolly_flutter/models/wpp/mlangword.dart';
import 'package:lolly_flutter/services/wpp/lang_word_service.dart';
import 'package:rx_command/rx_command.dart';
import 'package:rxdart/rxdart.dart';

import '../misc/settings_viewmodel.dart';

class WordsLangViewModel {
  List<MLangWord> lstLangWordsAll = [], lstLangWords = [];
  final langWordService = LangWordService();
  var reloaded = false;
  late RxCommand<void, List<MLangWord>> reloadCommand;
  final textFilter_ =
      RxCommand.createSync((String s) => s, initialLastResult: "");
  String get textFilter => textFilter_.lastResult!;
  final scopeFilter_ = RxCommand.createSync((String s) => s,
      initialLastResult: SettingsViewModel.scopeWordFilters[0]);
  String get scopeFilter => scopeFilter_.lastResult!;

  WordsLangViewModel() {
    reloadCommand = RxCommand.createAsyncNoParam<List<MLangWord>>(() async {
      if (!reloaded) {
        lstLangWordsAll =
            await langWordService.getDataByLang(vmSettings.selectedLang!.id);
        reloaded = true;
      }
      _applyFilters();
      return lstLangWords;
    });
    textFilter_
        .debounceTime(const Duration(milliseconds: 500))
        .listen(reloadCommand.call);
    scopeFilter_.listen(reloadCommand.call);
  }

  void _applyFilters() => lstLangWords = textFilter.isEmpty
      ? lstLangWordsAll
      : lstLangWordsAll
          .where((o) => (scopeFilter == "Word" ? o.word : o.note)
              .toLowerCase()
              .contains(textFilter.toLowerCase()))
          .toList();

  MLangWord newLangWord() => MLangWord()..langid = vmSettings.selectedLang!.id;

  Future update(MLangWord item) async {
    await langWordService.update(item);
  }

  Future create(MLangWord item) async {
    item.id = await langWordService.create(item);
    lstLangWordsAll.add(item);
    _applyFilters();
  }
}
