import 'package:flutter/material.dart';
import 'package:lolly_flutter/main.dart';
import 'package:lolly_flutter/viewmodels/words/words_dict_viewmodel.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../packages/swipedetector-1.2.0/swipedetector.dart';
import '../misc/online_dict.dart';

class WordsDictPage extends StatefulWidget {
  final WordsDictViewModel vm;

  WordsDictPage(List<String> lstWords, int index)
      : vm = WordsDictViewModel(lstWords, index);

  @override
  WordsDictPageState createState() => WordsDictPageState(vm);
}

class WordsDictPageState extends State<WordsDictPage> {
  final WordsDictViewModel vm;
  late OnlineDict onlineDict;

  WordsDictPageState(this.vm) {
    onlineDict = OnlineDict(vm);
    vm.selectedWord_.listen((_) => onlineDict.searchDict());
    vmSettings.updateDictReference.listen((_) => onlineDict.searchDict());
  }

  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text('Dictionary')),
        body: Column(
          children: [
            Row(children: [
              Expanded(
                  child: StreamBuilder(
                      stream: vm.selectedWord_,
                      builder: (context, snapshot) => DropdownButton(
                            value: vm.selectedWord,
                            items: vm.lstWords
                                .map((e) => DropdownMenuItem(
                                    value: e, child: Text(e.label)))
                                .toList(),
                            isExpanded: true,
                            onChanged: vm.selectedWord_,
                          ))),
              Expanded(
                  child: StreamBuilder(
                      stream: vmSettings.selectedDictReference_,
                      builder: (context, snapshot) => DropdownButton(
                          value: vmSettings.selectedDictReference,
                          items: vmSettings.lstDictsReference
                              .map((e) => DropdownMenuItem(
                                  value: e, child: Text(e.dictname)))
                              .toList(),
                          isExpanded: true,
                          onChanged: vmSettings.selectedDictReference_)))
            ]),
            Expanded(
                child: SwipeDetector(
              child: WebView(
                  initialUrl: vm.getUrl,
                  onWebViewCreated: (c) => onlineDict.controller = c,
                  onPageFinished: (s) => onlineDict.onPageFinished()),
              onSwipeLeft: () => vm.next(-1),
              onSwipeRight: () => vm.next(1),
            ))
          ],
        ),
      );
}
