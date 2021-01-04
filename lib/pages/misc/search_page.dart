import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lolly_flutter/main.dart';
import 'package:lolly_flutter/models/misc/mcommon.dart';
import 'package:lolly_flutter/services/misc/base_service.dart';
import 'package:lolly_flutter/viewmodels/misc/search_viewmodel.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SearchPage extends StatefulWidget {
  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  final vm = SearchViewModel();
  WebViewController controller;
  var dictStatus = DictWebBrowserStatus.Ready;

  Widget build(BuildContext context) {
    return Column(children: [
      TextField(
          autocorrect: false,
          decoration: InputDecoration(
            hintText: "Filter",
          ),
          onChanged: (s) {
            setState(() => _searchDict());
            return s;
          }),
      Row(children: [
        Expanded(
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
                    }))),
      ]),
      Expanded(
        child: WebView(
            initialUrl: vm.currentUrl,
            onWebViewCreated: (c) => controller = c,
            onPageFinished: (s) async => await _onPageFinished()),
      )
    ]);
  }

  void _searchDict() async {
    final item = vmSettings.selectedDictReference;
    final url = item.urlString(vm.word, vmSettings.lstAutoCorrect);
    if (item.dicttypename == "OFFLINE") {
      final html = await BaseService.getHtmlByUrl(url);
      final str = item.htmlString(html, vm.word, true);
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
      final s = item.automation.replaceAll("{0}", vm.word);
      await controller.evaluateJavascript(s);
      dictStatus = DictWebBrowserStatus.Ready;
      if (item.dicttypename == "OFFLINE-ONLINE")
        dictStatus = DictWebBrowserStatus.Navigating;
    } else if (dictStatus == DictWebBrowserStatus.Navigating) {
      final html = await controller
          .evaluateJavascript("document.documentElement.outerHTML.toString()");
      final str = item.htmlString(html, vm.word, true);
      controller.loadUrl(Uri.dataFromString(str,
              mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
          .toString());
      dictStatus = DictWebBrowserStatus.Ready;
    }
  }
}
