import 'package:flutter/material.dart';
import 'package:lolly_flutter/main.dart';
import 'package:lolly_flutter/viewmodels/words/words_dict_viewmodel.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../packages/swipedetector-1.2.0/swipedetector.dart';
import '../misc/online_dict.dart';

class WordsDictPage extends StatefulWidget {
  final WordsDictViewModel vm;

  WordsDictPage(List<String> lstWords, int index, {super.key})
      : vm = WordsDictViewModel(lstWords, index);

  @override
  WordsDictPageState createState() => WordsDictPageState();
}

class WordsDictPageState extends State<WordsDictPage> {
  WordsDictViewModel get vm => widget.vm;
  late OnlineDict onlineDict;

  @override
  void initState() {
    super.initState();
    onlineDict = OnlineDict(vm, vm.getUrl);
    vm.selectedWord_.listen((_) => onlineDict.searchDict());
    vmSettings.updateDictReference.listen((_) => onlineDict.searchDict());
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Dictionary')),
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
                            onChanged: vm.selectedWord_.call,
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
                          onChanged: vmSettings.selectedDictReference_.call)))
            ]),
            Expanded(
                child: SwipeDetector(
              child: WebViewWidget(controller: onlineDict.controller),
              onSwipeLeft: () => vm.next(-1),
              onSwipeRight: () => vm.next(1),
            ))
          ],
        ),
      );
}
