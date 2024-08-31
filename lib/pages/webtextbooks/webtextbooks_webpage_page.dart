import 'package:flutter/material.dart';
import 'package:lolly_flutter/models/misc/mwebtextbook.dart';
import 'package:lolly_flutter/viewmodels/webtextbooks/webTextbooks_detail_viewmodel.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebTextbooksWebPagePage extends StatefulWidget {
  final WebTextbooksDetailViewModel vm;

  WebTextbooksWebPagePage(MWebTextbook item, {super.key})
      : vm = WebTextbooksDetailViewModel(item);

  @override
  WebTextbooksWebPagePageState createState() => WebTextbooksWebPagePageState();
}

class WebTextbooksWebPagePageState extends State<WebTextbooksWebPagePage> {
  MWebTextbook get item => widget.vm.item;
  late WebViewController controller;

  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(item.url));
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('WebTextbooks Web Page')),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            Center(child: Text(item.title)),
            Expanded(
              child: WebViewWidget(controller: controller),
            )
          ])));
}
