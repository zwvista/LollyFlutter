import 'package:flutter_command/flutter_command.dart';
import 'package:lolly_flutter/main.dart';
import 'package:lolly_flutter/models/wpp/munitphrase.dart';
import 'package:lolly_flutter/viewmodels/phrases/phrases_unit_viewmodel.dart';

class PhrasesUnitBatchEditViewModel {
  PhrasesUnitViewModel vm;

  final unitChecked = Command.createSync((bool v) => v, initialValue: false);
  final partChecked = Command.createSync((bool v) => v, initialValue: false);
  final seqnumChecked = Command.createSync((bool v) => v, initialValue: false);
  final unit = Command.createSync((int v) => v,
      initialValue: vmSettings.lstUnits[0].value);
  final part = Command.createSync((int v) => v,
      initialValue: vmSettings.lstParts[0].value);
  final seqnum = Command.createSync((String s) => s, initialValue: "0");
  final selectedItems = <MUnitPhrase>{};
  late Command<MUnitPhrase, void> selectedItemsCmd;

  PhrasesUnitBatchEditViewModel(this.vm) {
    selectedItemsCmd = Command.createSyncNoResult((entry) =>
        selectedItems.contains(entry)
            ? selectedItems.remove(entry)
            : selectedItems.add(entry));
  }
}
