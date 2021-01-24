import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lolly_flutter/main.dart';
import 'package:lolly_flutter/pages/misc/online_dict.dart';
import 'package:lolly_flutter/viewmodels/words/words_dict_viewmodel.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WordsDictPage extends StatefulWidget {
  WordsDictViewModel vm;

  WordsDictPage(List<String> lstWords, int index) {
    vm = WordsDictViewModel(lstWords, index);
  }
  @override
  WordsDictPageState createState() => WordsDictPageState(vm);
}

class WordsDictPageState extends State<WordsDictPage> {
  final WordsDictViewModel vm;
  OnlineDict onlineDict;

  WordsDictPageState(this.vm) {
    onlineDict = OnlineDict(vm);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dictionary')),
      body: Column(
        children: [
          Row(children: [
            Expanded(
                child: DropdownButton(
              value: vm.currentWord,
              items: vm.lstWords
                  .map((e) => DropdownMenuItem(value: e, child: Text(e.label)))
                  .toList(),
              isExpanded: true,
              onChanged: (value) => setState(() {
                vm.setIndex(value.value);
                onlineDict.searchDict();
              }),
            )),
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
                          onlineDict.searchDict();
                        })))
          ]),
          Expanded(
              child: SwipeDetector(
            child: WebView(
                initialUrl: vm.getUrl,
                onWebViewCreated: (c) => onlineDict.controller = c,
                onPageFinished: (s) => onlineDict.onPageFinished()),
            onSwipeLeft: () => setState(() {
              vm.next(-1);
              onlineDict.loadUrl();
            }),
            onSwipeRight: () => setState(() {
              vm.next(1);
              onlineDict.loadUrl();
            }),
          ))
        ],
      ),
    );
  }
}
