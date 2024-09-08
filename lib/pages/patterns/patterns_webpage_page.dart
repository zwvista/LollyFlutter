import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:lolly_flutter/models/wpp/mpattern.dart';
import 'package:lolly_flutter/viewmodels/patterns/patterns_webpage_viewmodel.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PatternsWebPagePage extends StatefulWidget {
  final PatternsWebPageViewmodel vm;

  PatternsWebPagePage(List<MPattern> lstPatterns, int index, {super.key})
      : vm = PatternsWebPageViewmodel(lstPatterns, index);

  @override
  PatternsWebPagePageState createState() => PatternsWebPagePageState();
}

class PatternsWebPagePageState extends State<PatternsWebPagePage> {
  PatternsWebPageViewmodel get vm => widget.vm;
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(vm.selectedPattern.url));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Patterns Web Page')),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            Expanded(
                child: StreamBuilder(
                    stream: vm.selectedPatternIndex_,
                    builder: (context, snapshot) => DropdownButton(
                          value: vm.selectedPatternIndex,
                          items: vm.lstPatterns
                              .mapIndexed((i, e) => DropdownMenuItem(
                                  value: i, child: Text(e.title)))
                              .toList(),
                          isExpanded: true,
                          onChanged: vm.selectedPatternIndex_.call,
                        ))),
            Expanded(
              child: WebViewWidget(controller: controller),
            )
          ])));
}
