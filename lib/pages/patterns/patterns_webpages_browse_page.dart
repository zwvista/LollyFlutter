import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lolly_flutter/models/wpp/mpattern.dart';
import 'package:lolly_flutter/viewmodels/patterns/patterns_webpages_viewmodel.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PatternsWebPagesBrowsePage extends StatefulWidget {
  PatternsWebPagesViewModel vm;

  PatternsWebPagesBrowsePage(MPattern item) {
    vm = PatternsWebPagesViewModel(item);
  }

  @override
  PatternsWebPagesBrowsePageState createState() =>
      PatternsWebPagesBrowsePageState(vm);
}

class PatternsWebPagesBrowsePageState
    extends State<PatternsWebPagesBrowsePage> {
  PatternsWebPagesViewModel vm;
  WebViewController controller;

  PatternsWebPagesBrowsePageState(this.vm);

  Widget build(BuildContext context) {
    return Column(children: [
      DropdownButton(
          value: vm.selectedWebPage,
          items: vm.lstPatternsWebPages
              .map((e) => DropdownMenuItem(value: e, child: Text(e.title)))
              .toList(),
          isExpanded: true,
          onChanged: (v) => setState(() {
                vm.selectedWebPage = v;
                controller.loadUrl(v.url);
              })),
      Expanded(
        child: WebView(onWebViewCreated: (c) => controller = c),
      )
    ]);
  }
}
