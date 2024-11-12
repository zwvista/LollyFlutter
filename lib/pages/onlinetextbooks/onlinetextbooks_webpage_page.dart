import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:lolly_flutter/models/misc/monlinetextbook.dart';
import 'package:lolly_flutter/viewmodels/onlinetextbooks/onlinetextbooks_webpage_viewmodel.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OnlineTextbooksWebPagePage extends StatefulWidget {
  final OnlineTextbooksWebPageViewModel vm;

  OnlineTextbooksWebPagePage(
      List<MOnlineTextbook> lstOnlineTextbooks, int index,
      {super.key})
      : vm = OnlineTextbooksWebPageViewModel(lstOnlineTextbooks, index);

  @override
  OnlineTextbooksWebPagePageState createState() =>
      OnlineTextbooksWebPagePageState();
}

class OnlineTextbooksWebPagePageState
    extends State<OnlineTextbooksWebPagePage> {
  OnlineTextbooksWebPageViewModel get vm => widget.vm;
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(vm.selectedOnlineTextbook.url));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Online Textbooks (Web Page)')),
      body: Column(children: [
        Row(children: [
          Expanded(
              child: StreamBuilder(
                  stream: vm.selectedOnlineTextbookIndex_,
                  builder: (context, snapshot) => DropdownButton(
                        value: vm.selectedOnlineTextbookIndex,
                        items: vm.lstOnlineTextbooks
                            .mapIndexed((i, e) => DropdownMenuItem(
                                value: i, child: Text(e.title)))
                            .toList(),
                        isExpanded: true,
                        onChanged: vm.selectedOnlineTextbookIndex_.call,
                      )))
        ]),
        Expanded(
          child: WebViewWidget(controller: controller),
        )
      ]));
}
