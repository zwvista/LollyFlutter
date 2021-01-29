import 'package:lolly_flutter/main.dart';
import 'package:lolly_flutter/models/misc/mtextbook.dart';
import 'package:lolly_flutter/viewmodels/phrases/phrases_unit_viewmodel.dart';

class PhrasesUnitBatchEditViewModel {
  PhrasesUnitViewModel vm;
  var unit = 0;
  var part = 0;
  var seqnum = 0;
  MTextbook get textbook => vmSettings.selectedTextbook;

  PhrasesUnitBatchEditViewModel(this.vm);
}
