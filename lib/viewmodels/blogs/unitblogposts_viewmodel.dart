import 'package:lolly_flutter/main.dart';
import 'package:lolly_flutter/models/misc/mcommon.dart';
import 'package:rx_command/rx_command.dart';

import '../../services/blogs/blog_service.dart';

class UnitBlogPostsViewModel {
  List<MSelectItem> lstUnits = vmSettings.lstUnits;
  final selectedUnitIndex_ = RxCommand.createSync((int v) => v);
  int get selectedUnitIndex => selectedUnitIndex_.lastResult!;
  int get selectedUnit => lstUnits[selectedUnitIndex].value;

  final blogService = BlogService();
  final unitBlogPostHtml = RxCommand.createSync((String v) => v);

  UnitBlogPostsViewModel() {
    selectedUnitIndex_.listen((_) async {
      final content = await vmSettings.getBlogContent(selectedUnit);
      final str = blogService.markedToHtml(content);
      unitBlogPostHtml(str);
    });
    select(lstUnits.indexWhere((o) => o.value == vmSettings.usunitto));
  }

  void select(int index) {
    selectedUnitIndex_(index);
  }

  void next(int delta) => selectedUnitIndex_(
      (selectedUnitIndex + delta + lstUnits.length) % lstUnits.length);
}
