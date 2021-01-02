import 'package:lolly_flutter/models/wpp/mpattern.dart';
import 'package:lolly_flutter/models/wpp/mpatternwebpage.dart';
import 'package:lolly_flutter/services/wpp/pattern_webpage_service.dart';
import 'package:rx_command/rx_command.dart';

class PatternsWebPagesViewModel {
  MPattern selectedPattern;
  List<MPatternWebPage> lstPatternsWebPages;
  final patternWebPageService = PatternWebPageService();
  RxCommand<void, List<MPatternWebPage>> reloadCommand;

  PatternsWebPagesViewModel(this.selectedPattern) {
    reloadCommand = RxCommand.createAsyncNoParam(() async =>
        lstPatternsWebPages =
            await patternWebPageService.getDataByPattern(selectedPattern.id));
    reloadCommand.execute();
  }
}
