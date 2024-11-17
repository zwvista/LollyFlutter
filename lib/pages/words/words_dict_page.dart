import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_command/flutter_command.dart';
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
    onlineDict = OnlineDict(vm);
    vm.selectedWordIndex_.listen((v, _) => onlineDict.searchDict());
    vmSettings.updateDictReference.listen((v, _) => onlineDict.searchDict());
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Dictionary')),
        body: Column(
          children: [
            Row(children: [
              Expanded(
                  child: ValueListenableBuilder(
                      valueListenable: vm.selectedWordIndex_,
                      builder: (context, value, _) => DropdownButton(
                            value: vm.selectedWordIndex,
                            items: vm.lstWords
                                .mapIndexed((i, e) =>
                                    DropdownMenuItem(value: i, child: Text(e)))
                                .toList(),
                            isExpanded: true,
                            onChanged: vm.selectedWordIndex_.call,
                          ))),
              Expanded(
                  child: ValueListenableBuilder(
                      valueListenable: vmSettings.selectedDictReference_,
                      builder: (context, value, _) => DropdownButton(
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
