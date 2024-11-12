import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:lolly_flutter/models/wpp/mpattern.dart';
import 'package:lolly_flutter/viewmodels/patterns/patterns_webpage_viewmodel.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../packages/swipedetector-1.2.0/swipedetector.dart';

class PatternsWebPagePage extends StatefulWidget {
  final PatternsWebPageViewModel vm;

  PatternsWebPagePage(List<MPattern> lstPatterns, int index, {super.key})
      : vm = PatternsWebPageViewModel(lstPatterns, index);

  @override
  PatternsWebPagePageState createState() => PatternsWebPagePageState();
}

class PatternsWebPagePageState extends State<PatternsWebPagePage> {
  PatternsWebPageViewModel get vm => widget.vm;
  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted);

  @override
  void initState() {
    super.initState();
    load() => controller.loadRequest(Uri.parse(vm.selectedPattern.url));
    vm.selectedPatternIndex_.listen((_) => load());
    load();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Patterns Web Page')),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            Row(children: [
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
                          )))
            ]),
            Expanded(
                child: SwipeDetector(
              child: WebViewWidget(controller: controller),
              onSwipeLeft: () => vm.next(-1),
              onSwipeRight: () => vm.next(1),
            ))
          ])));
}
