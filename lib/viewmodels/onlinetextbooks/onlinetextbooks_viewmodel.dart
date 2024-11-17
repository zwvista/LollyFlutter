import 'package:flutter_command/flutter_command.dart';
import 'package:lolly_flutter/main.dart';
import 'package:lolly_flutter/models/misc/monlinetextbook.dart';
import 'package:lolly_flutter/services/misc/onlinetextbook_service.dart';

class OnlineTextbooksViewModel {
  List<MOnlineTextbook> lstOnlineTextbooksAll = [], lstOnlineTextbooks = [];
  final onlineTextbookService = OnlineTextbookService();
  var reloaded = false;
  late Command<void, List<MOnlineTextbook>> reloadCommand;
  final onlineTextbookFilter_ =
      Command.createSync((int v) => v, initialValue: 0);
  int get onlineTextbookFilter => onlineTextbookFilter_.value;

  OnlineTextbooksViewModel() {
    reloadCommand = Command.createAsyncNoParam(() async {
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
    }, initialValue: []);
    onlineTextbookFilter_.listen((v, _) => reloadCommand());
  }
}
