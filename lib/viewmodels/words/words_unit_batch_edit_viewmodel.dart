import 'package:lolly_flutter/main.dart';
import 'package:lolly_flutter/models/misc/mtextbook.dart';
import 'package:lolly_flutter/viewmodels/words/words_unit_viewmodel.dart';

class WordsUnitBatchEditViewModel {
  WordsUnitViewModel vm;
  var unit = vmSettings.lstUnits[0].value;
  var part = vmSettings.lstParts[0].value;
  var seqnum = 0;
  var unitIsChecked = false;
  var partIsChecked = false;
  var seqnumIsChecked = false;
  MTextbook get textbook => vmSettings.selectedTextbook;

  WordsUnitBatchEditViewModel(this.vm);
}
