import 'package:lolly_flutter/main.dart';
import 'package:lolly_flutter/models/wpp/munitword.dart';
import 'package:lolly_flutter/viewmodels/words/words_unit_viewmodel.dart';
import 'package:rx_command/rx_command.dart';

class WordsUnitBatchEditViewModel {
  WordsUnitViewModel vm;

  final unitChecked =
      RxCommand.createSync((bool v) => v, initialLastResult: false);
  final partChecked =
      RxCommand.createSync((bool v) => v, initialLastResult: false);
  final seqnumChecked =
      RxCommand.createSync((bool v) => v, initialLastResult: false);
  final unit = RxCommand.createSync((int v) => v,
      initialLastResult: vmSettings.lstUnits[0].value);
  final part = RxCommand.createSync((int v) => v,
      initialLastResult: vmSettings.lstParts[0].value);
  final seqnum = RxCommand.createSync((String s) => s, initialLastResult: "0");
  final selectedItems = <MUnitWord>{};
  late RxCommand<MUnitWord, void> selectedItemsCmd;

  WordsUnitBatchEditViewModel(this.vm) {
    selectedItemsCmd = RxCommand.createSyncNoResult((entry) =>
        selectedItems.contains(entry)
            ? selectedItems.remove(entry)
            : selectedItems.add(entry));
  }
}
