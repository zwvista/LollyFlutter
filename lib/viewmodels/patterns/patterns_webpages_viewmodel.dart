import 'package:lolly_flutter/models/wpp/mpattern.dart';
import 'package:lolly_flutter/models/wpp/mpatternwebpage.dart';
import 'package:lolly_flutter/services/wpp/pattern_webpage_service.dart';
import 'package:rx_command/rx_command.dart';
import '../../main.dart';

class PatternsWebPagesViewModel {
  MPattern selectedPattern;
  List<MPatternWebPage> lstPatternsWebPages = [];
  MPatternWebPage? selectedWebPage;
  final patternWebPageService = PatternWebPageService();
  late RxCommand<void, List<MPatternWebPage>> reloadCommand;
  late RxCommand<MPatternWebPage, MPatternWebPage> selectionChangedCommand;

  PatternsWebPagesViewModel(this.selectedPattern) {
    reloadCommand = RxCommand.createAsyncNoParam(() async {
      lstPatternsWebPages =
          await patternWebPageService.getDataByPattern(selectedPattern.id);
      selectedWebPage =
          lstPatternsWebPages.firstWhereOrNull((e) => true);
      return lstPatternsWebPages;
    });
    selectionChangedCommand = RxCommand.createSync((s) => selectedWebPage = s);
    reloadCommand.execute();
  }
}
