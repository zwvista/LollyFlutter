import 'package:flutter_command/flutter_command.dart';
import 'package:lolly_flutter/main.dart';
import 'package:lolly_flutter/models/wpp/munitword.dart';
import 'package:lolly_flutter/viewmodels/words/words_unit_viewmodel.dart';

class WordsUnitBatchEditViewModel {
  WordsUnitViewModel vm;

  final unitChecked = Command.createSync((bool v) => v, initialValue: false);
  final partChecked = Command.createSync((bool v) => v, initialValue: false);
  final seqnumChecked = Command.createSync((bool v) => v, initialValue: false);
  final unit = Command.createSync((int v) => v,
      initialValue: vmSettings.lstUnits[0].value);
  final part = Command.createSync((int v) => v,
      initialValue: vmSettings.lstParts[0].value);
  final seqnum = Command.createSync((String s) => s, initialValue: "0");
  final selectedItems = <MUnitWord>{};
  late Command<MUnitWord, void> selectedItemsCmd;

  WordsUnitBatchEditViewModel(this.vm) {
    selectedItemsCmd = Command.createSyncNoResult((entry) =>
        selectedItems.contains(entry)
            ? selectedItems.remove(entry)
            : selectedItems.add(entry));
  }
}
