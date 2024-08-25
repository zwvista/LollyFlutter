import 'package:lolly_flutter/models/wpp/munitword.dart';
import 'package:lolly_flutter/viewmodels/words/words_unit_viewmodel.dart';

class WordsUnitDetailViewModel {
  WordsUnitViewModel vm;
  MUnitWord item;

  WordsUnitDetailViewModel(this.vm, this.item);

  Future save() async {
    if (item.id == 0) {
      await vm.create(item);
    } else {
      await vm.update(item);
    }
  }
}
