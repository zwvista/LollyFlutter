import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lolly_flutter/main.dart';
import 'package:lolly_flutter/models/misc/mcommon.dart';
import 'package:lolly_flutter/services/misc/base_service.dart';
import 'package:lolly_flutter/viewmodels/words/words_dict_viewmodel.dart';
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
  var dictStatus = DictWebBrowserStatus.Ready;

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
                    _searchDict();
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
                          _searchDict();
                        })))
          ]),
          Expanded(
              child: SwipeDetector(
            child: WebView(
                initialUrl: vm.currentUrl,
                onWebViewCreated: (c) => controller = c,
                onPageFinished: (s) async => await _onPageFinished()),
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

  void _searchDict() async {
    final item = vmSettings.selectedDictReference;
    final url = item.urlString(vm.currentWord.label, vmSettings.lstAutoCorrect);
    if (item.dicttypename == "OFFLINE") {
      final html = await BaseService.getHtmlByUrl(url);
      final str = item.htmlString(html, vm.currentWord.label, true);
      // https://stackoverflow.com/questions/53831312/how-to-render-a-local-html-file-with-flutter-dart-webview
      controller.loadUrl(Uri.dataFromString(str,
              mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
          .toString());
    } else {
      controller.loadUrl(vm.currentUrl);
      if (item.automation.isNotEmpty)
        dictStatus = DictWebBrowserStatus.Automating;
      else if (item.dicttypename == "OFFLINE-ONLINE")
        dictStatus = DictWebBrowserStatus.Navigating;
    }
  }

  void _onPageFinished() async {
    if (dictStatus == DictWebBrowserStatus.Ready) return;
    final item = vmSettings.selectedDictReference;
    if (dictStatus == DictWebBrowserStatus.Automating) {
      final s = item.automation.replaceAll("{0}", vm.currentWord.label);
      await controller.evaluateJavascript(s);
      dictStatus = DictWebBrowserStatus.Ready;
      if (item.dicttypename == "OFFLINE-ONLINE")
        dictStatus = DictWebBrowserStatus.Navigating;
    } else if (dictStatus == DictWebBrowserStatus.Navigating) {
      final html = await controller
          .evaluateJavascript("document.documentElement.outerHTML.toString()");
      final str = item.htmlString(html, vm.currentWord.label, true);
      controller.loadUrl(Uri.dataFromString(str,
              mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
          .toString());
      dictStatus = DictWebBrowserStatus.Ready;
    }
  }
}
