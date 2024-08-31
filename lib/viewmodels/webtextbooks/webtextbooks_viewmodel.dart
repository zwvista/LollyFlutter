import 'package:lolly_flutter/main.dart';
import 'package:lolly_flutter/models/misc/mwebtextbook.dart';
import 'package:lolly_flutter/services/misc/webtextbook_service.dart';
import 'package:rx_command/rx_command.dart';

class WebTextbooksViewModel {
  List<MWebTextbook> lstWebTextbooksAll = [], lstWebTextbooks = [];
  final webTextbookService = WebTextbookService();
  var reloaded = false;
  late RxCommand<void, List<MWebTextbook>> reloadCommand;
  final webTextbookFilter_ =
      RxCommand.createSync((int v) => v, initialLastResult: 0);
  int get webTextbookFilter => webTextbookFilter_.lastResult!;

  WebTextbooksViewModel() {
    reloadCommand = RxCommand.createAsyncNoParam(() async {
      if (!reloaded) {
        lstWebTextbooksAll =
            await webTextbookService.getDataByLang(vmSettings.selectedLang!.id);
        reloaded = true;
      }
      lstWebTextbooks = webTextbookFilter == 0
          ? lstWebTextbooksAll
          : lstWebTextbooksAll
              .where((o) =>
                  webTextbookFilter == 0 || o.textbookid == webTextbookFilter)
              .toList();
      return lstWebTextbooks;
    });
    webTextbookFilter_.listen(reloadCommand.call);
  }
}
