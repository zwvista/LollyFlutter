import 'package:flutter_command/flutter_command.dart';
import 'package:lolly_flutter/viewmodels/misc/search_viewmodel.dart';

class WordsDictViewModel implements IOnlineDict {
  List<String> lstWords;
  final selectedWordIndex_ = Command.createSync((int v) => v, initialValue: 0);
  int get selectedWordIndex => selectedWordIndex_.value;
  @override
  String get getWord => lstWords[selectedWordIndex];

  WordsDictViewModel(this.lstWords, int index) {
    selectedWordIndex_(index);
  }

  void next(int delta) => selectedWordIndex_(
      (selectedWordIndex + delta + lstWords.length) % lstWords.length);
}
