import 'package:lolly_flutter/main.dart';
import 'package:lolly_flutter/viewmodels/phrases/phrases_unit_viewmodel.dart';
import 'package:rx_command/rx_command.dart';

class PhrasesUnitBatchEditViewModel {
  PhrasesUnitViewModel vm;

  final unitIsChecked =
      RxCommand.createSync((bool v) => v, initialLastResult: false);
  final partIsChecked =
      RxCommand.createSync((bool v) => v, initialLastResult: false);
  final seqnumIsChecked =
      RxCommand.createSync((bool v) => v, initialLastResult: false);
  final unit = RxCommand.createSync((int v) => v,
      initialLastResult: vmSettings.lstUnits[0].value);
  final part = RxCommand.createSync((int v) => v,
      initialLastResult: vmSettings.lstParts[0].value);
  final seqnum = RxCommand.createSync((String s) => s, initialLastResult: "0");

  PhrasesUnitBatchEditViewModel(this.vm);
}
