import 'package:lolly_flutter/models/wpp/mlangphrase.dart';
import 'package:lolly_flutter/viewmodels/phrases/phrases_lang_viewmodel.dart';

class PhrasesLangDetailViewModel {
  PhrasesLangViewModel vm;
  MLangPhrase item;

  PhrasesLangDetailViewModel(this.vm, this.item);

  Future save() async {
    if (item.id == 0) {
      await vm.create(item);
    } else {
      await vm.update(item);
    }
  }
}
