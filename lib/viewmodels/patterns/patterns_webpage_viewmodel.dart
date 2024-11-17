import 'package:flutter_command/flutter_command.dart';
import 'package:lolly_flutter/models/wpp/mpattern.dart';

class PatternsWebPageViewModel {
  List<MPattern> lstPatterns;
  final selectedPatternIndex_ =
      Command.createSync((int v) => v, initialValue: 0);
  int get selectedPatternIndex => selectedPatternIndex_.value;
  MPattern get selectedPattern => lstPatterns[selectedPatternIndex];

  PatternsWebPageViewModel(this.lstPatterns, int index) {
    selectedPatternIndex_(index);
  }

  void next(int delta) => selectedPatternIndex_(
      (selectedPatternIndex + delta + lstPatterns.length) % lstPatterns.length);
}
