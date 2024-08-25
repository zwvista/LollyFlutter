import 'package:flutter/material.dart';
import 'package:lolly_flutter/models/wpp/mpattern.dart';
import 'package:lolly_flutter/viewmodels/patterns/patterns_detail_viewmodel.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PatternsWebPagePage extends StatefulWidget {
  final PatternsDetailViewModel vm;

  PatternsWebPagePage(MPattern item) : vm = PatternsDetailViewModel(item);

  @override
  PatternsWebPagePageState createState() => PatternsWebPagePageState(vm);
}

class PatternsWebPagePageState extends State<PatternsWebPagePage> {
  final PatternsDetailViewModel vm;

  PatternsWebPagePageState(this.vm) {}

  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: Text('Patterns Web Page')),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            Center(child: Text(vm.item.title)),
            Expanded(
              child: WebView(
                  onWebViewCreated: (c) => c.loadUrl(vm.item.url ?? "")),
            )
          ])));
}
