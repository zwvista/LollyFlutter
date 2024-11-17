import 'package:flutter_command/flutter_command.dart';
import 'package:lolly_flutter/models/misc/monlinetextbook.dart';

class OnlineTextbooksWebPageViewModel {
  List<MOnlineTextbook> lstOnlineTextbooks;
  final selectedOnlineTextbookIndex_ =
      Command.createSync((int v) => v, initialValue: 0);
  int get selectedOnlineTextbookIndex => selectedOnlineTextbookIndex_.value;
  MOnlineTextbook get selectedOnlineTextbook =>
      lstOnlineTextbooks[selectedOnlineTextbookIndex];

  OnlineTextbooksWebPageViewModel(this.lstOnlineTextbooks, int index) {
    selectedOnlineTextbookIndex_(index);
  }

  void next(int delta) => selectedOnlineTextbookIndex_(
      (selectedOnlineTextbookIndex + delta + lstOnlineTextbooks.length) %
          lstOnlineTextbooks.length);
}
