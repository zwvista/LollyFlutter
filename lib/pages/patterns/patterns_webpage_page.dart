import 'package:flutter/material.dart';
import 'package:lolly_flutter/models/wpp/mpattern.dart';
import 'package:lolly_flutter/viewmodels/patterns/patterns_detail_viewmodel.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PatternsWebPagePage extends StatefulWidget {
  final PatternsDetailViewModel vm;

  PatternsWebPagePage(MPattern item, {super.key})
      : vm = PatternsDetailViewModel(item);

  @override
  PatternsWebPagePageState createState() => PatternsWebPagePageState();
}

class PatternsWebPagePageState extends State<PatternsWebPagePage> {
  MPattern get item => widget.vm.item;
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(item.url));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Patterns Web Page')),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            Center(child: Text(item.title)),
            Expanded(
              child: WebViewWidget(controller: controller),
            )
          ])));
}
