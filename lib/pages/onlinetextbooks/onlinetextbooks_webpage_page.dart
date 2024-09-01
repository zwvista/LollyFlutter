import 'package:flutter/material.dart';
import 'package:lolly_flutter/models/misc/monlinetextbook.dart';
import 'package:lolly_flutter/viewmodels/onlinetextbooks/onlinetextbooks_detail_viewmodel.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OnlineTextbooksWebPagePage extends StatefulWidget {
  final OnlineTextbooksDetailViewModel vm;

  OnlineTextbooksWebPagePage(MOnlineTextbook item, {super.key})
      : vm = OnlineTextbooksDetailViewModel(item);

  @override
  OnlineTextbooksWebPagePageState createState() =>
      OnlineTextbooksWebPagePageState();
}

class OnlineTextbooksWebPagePageState
    extends State<OnlineTextbooksWebPagePage> {
  MOnlineTextbook get item => widget.vm.item;
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
      appBar: AppBar(title: const Text('Online Textbooks (Web Page)')),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            Center(child: Text(item.title)),
            Expanded(
              child: WebViewWidget(controller: controller),
            )
          ])));
}
