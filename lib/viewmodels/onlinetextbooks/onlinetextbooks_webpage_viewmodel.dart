import 'package:lolly_flutter/models/misc/monlinetextbook.dart';
import 'package:rx_command/rx_command.dart';

class OnlineTextbooksWebPageViewModel {
  List<MOnlineTextbook> lstOnlineTextbooks;
  final selectedOnlineTextbookIndex_ = RxCommand.createSync((int v) => v);
  int get selectedOnlineTextbookIndex =>
      selectedOnlineTextbookIndex_.lastResult!;
  MOnlineTextbook get selectedOnlineTextbook =>
      lstOnlineTextbooks[selectedOnlineTextbookIndex];

  OnlineTextbooksWebPageViewModel(this.lstOnlineTextbooks, int index) {
    selectedOnlineTextbookIndex_(index);
  }

  void next(int delta) => selectedOnlineTextbookIndex_(
      (selectedOnlineTextbookIndex + delta + lstOnlineTextbooks.length) %
          lstOnlineTextbooks.length);
}
