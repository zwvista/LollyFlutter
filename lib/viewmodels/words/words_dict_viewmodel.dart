import 'package:lolly_flutter/viewmodels/misc/search_viewmodel.dart';
import 'package:rx_command/rx_command.dart';

class WordsDictViewModel implements IOnlineDict {
  List<String> lstWords;
  final selectedWordIndex_ = RxCommand.createSync((int v) => v);
  int get selectedWordIndex => selectedWordIndex_.lastResult!;
  @override
  String get getWord => lstWords[selectedWordIndex];

  WordsDictViewModel(this.lstWords, int index) {
    selectedWordIndex_(index);
  }

  void next(int delta) => selectedWordIndex_(
      (selectedWordIndex + delta + lstWords.length) % lstWords.length);
}
