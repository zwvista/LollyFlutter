import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../packages/swipedetector-1.2.0/swipedetector.dart';
import '../../viewmodels/blogs/unitblogposts_viewmodel.dart';

class UnitBlogPostsPage extends StatefulWidget {
  const UnitBlogPostsPage({super.key});

  @override
  UnitBlogPostsPageState createState() => UnitBlogPostsPageState();
}

class UnitBlogPostsPageState extends State<UnitBlogPostsPage> {
  UnitBlogPostsViewModel vm = UnitBlogPostsViewModel();
  WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted);

  UnitBlogPostsPageState() {}

  @override
  void initState() {
    super.initState();
    vm.unitBlogPostHtml.listen((v, _) => controller.loadHtmlString(v));
  }

  @override
  Widget build(BuildContext context) => Column(children: [
        Row(children: [
          Expanded(
              child: ValueListenableBuilder(
                  valueListenable: vm.selectedUnitIndex,
                  builder: (context, value, _) => DropdownButton(
                        value: value,
                        items: vm.lstUnits
                            .mapIndexed((i, e) => DropdownMenuItem(
                                value: i, child: Text(e.label)))
                            .toList(),
                        isExpanded: true,
                        onChanged: vm.selectedUnitIndex.call,
                      )))
        ]),
        Expanded(
            child: SwipeDetector(
          child: WebViewWidget(controller: controller),
          onSwipeLeft: () => vm.next(-1),
          onSwipeRight: () => vm.next(1),
        ))
      ]);
}
