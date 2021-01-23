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

  PatternsWebPagesBrowsePageState(this.vm) {
    void loadPage() => controller.loadUrl(vm.selectedWebPage.url);
    vm.reloadCommand.listen((_) => loadPage());
    vm.selectionChangedCommand.listen((_) => loadPage());
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Patterns Web Pages(Browse)')),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: [
              StreamBuilder(
                  stream: vm.reloadCommand,
                  builder: (context, snapshot) => DropdownButton(
                      value: vm.selectedWebPage,
                      items: vm.lstPatternsWebPages
                          .map((e) =>
                              DropdownMenuItem(value: e, child: Text(e.title)))
                          .toList(),
                      isExpanded: true,
                      onChanged: vm.selectionChangedCommand)),
              Expanded(
                child: WebView(onWebViewCreated: (c) => controller = c),
              )
            ])));
  }
}
