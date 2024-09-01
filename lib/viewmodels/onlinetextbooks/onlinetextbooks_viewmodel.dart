import 'package:lolly_flutter/main.dart';
import 'package:lolly_flutter/models/misc/monlinetextbook.dart';
import 'package:lolly_flutter/services/misc/onlinetextbook_service.dart';
import 'package:rx_command/rx_command.dart';

class OnlineTextbooksViewModel {
  List<MOnlineTextbook> lstOnlineTextbooksAll = [], lstOnlineTextbooks = [];
  final onlineTextbookService = OnlineTextbookService();
  var reloaded = false;
  late RxCommand<void, List<MOnlineTextbook>> reloadCommand;
  final onlineTextbookFilter_ =
      RxCommand.createSync((int v) => v, initialLastResult: 0);
  int get onlineTextbookFilter => onlineTextbookFilter_.lastResult!;

  OnlineTextbooksViewModel() {
    reloadCommand = RxCommand.createAsyncNoParam(() async {
      if (!reloaded) {
        lstOnlineTextbooksAll = await onlineTextbookService
            .getDataByLang(vmSettings.selectedLang!.id);
        reloaded = true;
      }
      lstOnlineTextbooks = onlineTextbookFilter == 0
          ? lstOnlineTextbooksAll
          : lstOnlineTextbooksAll
              .where((o) =>
                  onlineTextbookFilter == 0 ||
                  o.textbookid == onlineTextbookFilter)
              .toList();
      return lstOnlineTextbooks;
    });
    onlineTextbookFilter_.listen(reloadCommand.call);
  }
}
