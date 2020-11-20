import 'package:scoped_model/scoped_model.dart';

class WordsDictViewModel extends Model {
  List<String> lstWords;
  var currentWordIndex = 0;
  String get currentWord => lstWords[currentWordIndex];
  void next(int delta) => currentWordIndex =
      (currentWordIndex + delta + lstWords.length) % lstWords.length;

  WordsDictViewModel(List<String> lstWords, int index) {
    this.lstWords = lstWords;
    currentWordIndex = index;
  }
}
