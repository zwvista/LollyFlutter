import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lolly_flutter/main.dart';
import 'package:lolly_flutter/viewmodels/words/wordsdictviewmodel.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WordsDictPage extends StatefulWidget {
  WordsDictViewModel vm;

  WordsDictPage(List<String> lstWords, int index) {
    vm = WordsDictViewModel(lstWords, index);
  }
  @override
  WordsDictPageState createState() {
    return WordsDictPageState(vm);
  }
}

class WordsDictPageState extends State<WordsDictPage> {
  final WordsDictViewModel vm;
  WebViewController controller;

  WordsDictPageState(this.vm);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dictionary')),
      body: Column(
        children: <Widget>[
          Row(children: <Widget>[
            Expanded(
                flex: 1,
                child: DropdownButton(
                  value: vm.currentWord,
                  items: vm.lstWords
                      .map((e) =>
                          DropdownMenuItem(value: e, child: Text(e.label)))
                      .toList(),
                  isExpanded: true,
                  onChanged: (value) => setState(() {
                    vm.setIndex(value.value);
                    controller.loadUrl(vm.currentUrl);
                  }),
                )),
            Expanded(
                flex: 1,
                child: DropdownButton(
                    value: vmSettings.selectedDictReference,
                    items: vmSettings.lstDictsReference
                        .map((e) =>
                            DropdownMenuItem(value: e, child: Text(e.dictname)))
                        .toList(),
                    isExpanded: true,
                    onChanged: (value) => setState(() {
                          vmSettings.setSelectedDictReference(value);
                          controller.loadUrl(vm.currentUrl);
                        })))
          ]),
          Expanded(
              child: SwipeDetector(
            child: WebView(
                initialUrl: vm.currentUrl,
                onWebViewCreated: (c) => controller = c),
            onSwipeLeft: () => setState(() {
              vm.next(-1);
              controller.loadUrl(vm.currentUrl);
            }),
            onSwipeRight: () => setState(() {
              vm.next(1);
              controller.loadUrl(vm.currentUrl);
            }),
          ))
        ],
      ),
    );
  }
}
