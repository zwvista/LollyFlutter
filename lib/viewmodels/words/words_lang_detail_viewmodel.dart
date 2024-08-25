import 'package:lolly_flutter/models/wpp/mlangword.dart';
import 'package:lolly_flutter/viewmodels/words/words_lang_viewmodel.dart';

class WordsLangDetailViewModel {
  WordsLangViewModel vm;
  MLangWord item;

  WordsLangDetailViewModel(this.vm, this.item);

  Future save() async {
    if (item.id == 0) {
      await vm.create(item);
    } else {
      await vm.update(item);
    }
  }
}
