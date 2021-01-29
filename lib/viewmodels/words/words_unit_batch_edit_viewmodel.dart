import 'package:lolly_flutter/main.dart';
import 'package:lolly_flutter/models/misc/mtextbook.dart';
import 'package:lolly_flutter/viewmodels/words/words_unit_viewmodel.dart';

class WordsUnitBatchEditViewModel {
  WordsUnitViewModel vm;
  var unit = 0;
  var part = 0;
  var seqnum = 0;
  MTextbook get textbook => vmSettings.selectedTextbook;

  WordsUnitBatchEditViewModel(this.vm);
}
