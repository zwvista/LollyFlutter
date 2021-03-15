import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lolly_flutter/main.dart';
import 'package:lolly_flutter/viewmodels/misc/search_viewmodel.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'online_dict.dart';

class SearchPage extends StatefulWidget {
  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  final vm = SearchViewModel();
  OnlineDict onlineDict;

  SearchPageState() {
    onlineDict = OnlineDict(vm);
    vmSettings.setSelectedLang_.listen((v) => onlineDict.searchDict());
    vmSettings.setSelectedDictReference_.listen((v) => onlineDict.searchDict());
  }

  Widget build(BuildContext context) {
    return Column(children: [
      TextField(
          autocorrect: false,
          decoration: InputDecoration(
            hintText: "Enter a word here",
          ),
          onChanged: (s) {
            setState(() {
              vm.word = s;
              onlineDict.searchDict();
            });
            return s;
          }),
      Row(children: [
        Expanded(
            child: StreamBuilder(
                stream: vmSettings.selectedLang_,
                builder: (context, snapshot) => DropdownButton(
                    value: vmSettings.selectedLang,
                    items: vmSettings.lstLanguages
                        .map((e) =>
                            DropdownMenuItem(value: e, child: Text(e.langname)))
                        .toList(),
                    isExpanded: true,
                    onChanged: vmSettings.selectedLang_))),
        Expanded(
            child: StreamBuilder(
                stream: vmSettings.selectedDictReference_,
                builder: (context, snapshot) => DropdownButton(
                    value: vmSettings.selectedDictReference,
                    items: vmSettings.lstDictsReference
                        .map((e) =>
                            DropdownMenuItem(value: e, child: Text(e.dictname)))
                        .toList(),
                    isExpanded: true,
                    onChanged: vmSettings.selectedDictReference_))),
      ]),
      Expanded(
        child: WebView(
            initialUrl: vm.getUrl,
            onWebViewCreated: (c) => onlineDict.controller = c,
            onPageFinished: (s) => onlineDict.onPageFinished()),
      )
    ]);
  }
}
