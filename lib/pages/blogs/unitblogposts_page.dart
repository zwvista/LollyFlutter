import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../main.dart';
import '../../viewmodels/blogs/unitblogposts_viewmodel.dart';

class UnitBlogPostsPage extends StatefulWidget {
  const UnitBlogPostsPage({super.key});

  @override
  UnitBlogPostsPageState createState() => UnitBlogPostsPageState();
}

class UnitBlogPostsPageState extends State<UnitBlogPostsPage> {
  UnitBlogPostsViewModel vm = UnitBlogPostsViewModel();
  late WebViewController controller;

  UnitBlogPostsPageState() {}

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
    vm.selectedUnitIndex_.listen((_) async {
      final content = await vmSettings.getBlogContent(vm.selectedUnit);
      controller.loadHtmlString(content);
    });
  }

  @override
  Widget build(BuildContext context) => Column(children: [
        Row(children: [
          Expanded(
              child: StreamBuilder(
                  stream: vm.selectedUnitIndex_,
                  builder: (context, snapshot) => DropdownButton(
                        value: vm.selectedUnitIndex,
                        items: vm.lstUnits
                            .mapIndexed((i, e) => DropdownMenuItem(
                                value: i, child: Text(e.label)))
                            .toList(),
                        isExpanded: true,
                        onChanged: vm.selectedUnitIndex_.call,
                      )))
        ]),
        Expanded(
          child: WebViewWidget(controller: controller),
        )
      ]);
}
