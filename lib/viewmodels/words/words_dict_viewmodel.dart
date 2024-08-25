import 'package:lolly_flutter/main.dart';
import 'package:lolly_flutter/models/misc/mcommon.dart';
import 'package:lolly_flutter/viewmodels/misc/search_viewmodel.dart';
import 'package:rx_command/rx_command.dart';

class WordsDictViewModel implements IOnlineDict {
  List<MSelectItem> lstWords = [];
  final selectedWord_ = RxCommand.createSync((MSelectItem v) => v);
  MSelectItem get selectedWord => selectedWord_.lastResult!;
  @override
  String get getWord => selectedWord.label;
  @override
  String get getUrl =>
      vmSettings.selectedDictReference
          ?.urlString(selectedWord.label, vmSettings.lstAutoCorrect) ??
      "";

  WordsDictViewModel(List<String> lstWords, int index) {
    this.lstWords = lstWords
        .asMap()
        .map((k, v) => MapEntry(k, MSelectItem(k, v)))
        .values
        .toList();
    selectedWord_(this.lstWords[index]);
  }

  void next(int delta) => selectedWord_(lstWords[
      (selectedWord.value + delta + lstWords.length) % lstWords.length]);
}
