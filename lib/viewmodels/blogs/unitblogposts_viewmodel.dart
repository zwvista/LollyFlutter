import 'package:flutter_command/flutter_command.dart';
import 'package:lolly_flutter/main.dart';
import 'package:lolly_flutter/models/misc/mcommon.dart';

import '../../services/blogs/blog_service.dart';

class UnitBlogPostsViewModel {
  List<MSelectItem> lstUnits = vmSettings.lstUnits;
  final selectedUnitIndex = Command.createSync((int v) => v, initialValue: 0);

  final blogService = BlogService();
  final unitBlogPostHtml =
      Command.createSync((String v) => v, initialValue: '');

  UnitBlogPostsViewModel() {
    selectedUnitIndex.listen((v, _) async {
      final content = await vmSettings.getBlogContent(v);
      final str = blogService.markedToHtml(content);
      unitBlogPostHtml(str);
    });
    selectedUnitIndex(
        lstUnits.indexWhere((o) => o.value == vmSettings.usunitto));
  }

  void next(int delta) => selectedUnitIndex(
      (selectedUnitIndex.value + delta + lstUnits.length) % lstUnits.length);
}
