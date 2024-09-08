import 'package:lolly_flutter/models/wpp/mpattern.dart';
import 'package:rx_command/rx_command.dart';

class PatternsWebPageViewmodel {
  List<MPattern> lstPatterns;
  final selectedPatternIndex_ = RxCommand.createSync((int v) => v);
  int get selectedPatternIndex => selectedPatternIndex_.lastResult!;
  MPattern get selectedPattern => lstPatterns[selectedPatternIndex];

  PatternsWebPageViewmodel(this.lstPatterns, int index) {
    selectedPatternIndex_(index);
  }

  void next(int delta) => selectedPatternIndex_(
      (selectedPatternIndex + delta + lstPatterns.length) % lstPatterns.length);
}
