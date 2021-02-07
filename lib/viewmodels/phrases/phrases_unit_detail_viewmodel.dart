import 'package:lolly_flutter/models/wpp/munitphrase.dart';
import 'package:lolly_flutter/viewmodels/phrases/phrases_unit_viewmodel.dart';

class PhrasesUnitDetailViewModel {
  PhrasesUnitViewModel vm;
  MUnitPhrase item;

  PhrasesUnitDetailViewModel(this.vm, this.item);

  Future save() async {
    if (item.id == 0)
      await vm.create(item);
    else
      await vm.update(item);
  }
}
