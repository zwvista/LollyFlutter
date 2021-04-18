import 'package:lolly_flutter/main.dart';
import 'package:lolly_flutter/models/wpp/munitphrase.dart';
import 'package:lolly_flutter/viewmodels/phrases/phrases_unit_viewmodel.dart';
import 'package:rx_command/rx_command.dart';

class PhrasesUnitBatchEditViewModel {
  PhrasesUnitViewModel vm;

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
  final selectedItems = Set<MUnitPhrase>();
  RxCommand<MUnitPhrase, void> selectedItemsCmd;

  PhrasesUnitBatchEditViewModel(this.vm) {
    selectedItemsCmd = RxCommand.createSyncNoResult((entry) =>
        selectedItems.contains(entry)
            ? selectedItems.remove(entry)
            : selectedItems.add(entry));
  }
}
