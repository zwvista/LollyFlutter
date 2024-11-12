import 'package:lolly_flutter/main.dart';
import 'package:lolly_flutter/models/misc/mcommon.dart';
import 'package:rx_command/rx_command.dart';

class UnitBlogPostsViewModel {
  List<MSelectItem> lstUnits = vmSettings.lstUnits;
  final selectedUnitIndex_ =
      RxCommand.createSync((int v) => v, initialLastResult: 0);
  int get selectedUnitIndex => selectedUnitIndex_.lastResult!;
  int get selectedUnit => lstUnits[selectedUnitIndex].value;
  String unitBlogPostContent = '';

  UnitBlogPostsViewModel() {}

  void select(int index) {
    selectedUnitIndex_(index);
  }

  void next(int delta) => selectedUnitIndex_(
      (selectedUnitIndex + delta + lstUnits.length) % lstUnits.length);
}
