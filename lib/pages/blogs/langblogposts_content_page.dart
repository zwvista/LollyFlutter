import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../models/blogs/mlangblogpost.dart';
import '../../packages/swipedetector-1.2.0/swipedetector.dart';
import '../../viewmodels/blogs/langblogposts_content_viewmodel.dart';

class LangBlogPostsContentPage extends StatefulWidget {
  final LangBlogPostsContentViewModel vm;

  LangBlogPostsContentPage(List<MLangBlogPost> lstLangBlogPosts, int index,
      {super.key})
      : vm = LangBlogPostsContentViewModel(lstLangBlogPosts, index);

  @override
  LangBlogPostsContentPageState createState() =>
      LangBlogPostsContentPageState();
}

class LangBlogPostsContentPageState extends State<LangBlogPostsContentPage> {
  LangBlogPostsContentViewModel get vm => widget.vm;
  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted);

  @override
  void initState() {
    super.initState();
    load() => controller.loadRequest(Uri.parse(vm.selectedLangBlogPost.url));
    vm.selectedLangBlogPostIndex_.listen((v, _) => load());
    load();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Online Textbooks (Web Page)')),
      body: Column(children: [
        Row(children: [
          Expanded(
              child: ValueListenableBuilder(
                  valueListenable: vm.selectedLangBlogPostIndex_,
                  builder: (context, value, _) => DropdownButton(
                        value: vm.selectedLangBlogPostIndex,
                        items: vm.lstLangBlogPosts
                            .mapIndexed((i, e) => DropdownMenuItem(
                                value: i, child: Text(e.title)))
                            .toList(),
                        isExpanded: true,
                        onChanged: vm.selectedLangBlogPostIndex_.call,
                      )))
        ]),
        Expanded(
            child: SwipeDetector(
          child: WebViewWidget(controller: controller),
          onSwipeLeft: () => vm.next(-1),
          onSwipeRight: () => vm.next(1),
        ))
      ]));
}
