import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lolly_flutter/pages/misc/review_options_page.dart';
import 'package:lolly_flutter/viewmodels/words/words_review_viewmodel.dart';

class WordsReviewPage extends StatefulWidget {
  final state = _WordsReviewPageState();
  @override
  _WordsReviewPageState createState() => state;
}

class _WordsReviewPageState extends State<WordsReviewPage> {
  final vm = WordsReviewViewModel(() {});

  _WordsReviewPageState() {
    more();
  }

  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(children: [
        Row(
          children: [
            StreamBuilder(
                stream: vm.indexIsVisible_,
                builder: (context, snapshot) => Visibility(
                    visible: vm.indexIsVisible,
                    child: StreamBuilder(
                        stream: vm.indexString_,
                        builder: (context, snapshot) => Text(vm.indexString)))),
            Expanded(
                child: StreamBuilder(
                    stream: vm.accuracyIsVisible_,
                    builder: (context, snapshot) => Visibility(
                        visible: vm.accuracyIsVisible,
                        child: StreamBuilder(
                            stream: vm.accuracyString_,
                            builder: (context, snapshot) => Text(
                                vm.accuracyString,
                                textAlign: TextAlign.center))))),
            Stack(
              children: [
                StreamBuilder(
                    stream: vm.correctIsVisible_,
                    builder: (context, snapshot) => Visibility(
                        visible: vm.correctIsVisible,
                        child: Text("Correct",
                            style: TextStyle(color: Colors.green)))),
                StreamBuilder(
                    stream: vm.incorrectIsVisible_,
                    builder: (context, snapshot) => Visibility(
                        visible: vm.incorrectIsVisible,
                        child: Text("Incorrect",
                            style: TextStyle(color: Colors.pink))))
              ],
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(child: Text("Speak"), onPressed: () {}),
            StreamBuilder(
                stream: vm.checkEnabled_,
                builder: (context, snapshot) => StreamBuilder(
                    stream: vm.checkString_,
                    builder: (context, snapshot) => TextButton(
                        child: Text(vm.checkString),
                        onPressed: !vm.checkEnabled ? null : () => vm.check())))
          ],
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              StreamBuilder(
                  stream: vm.wordTargetIsVisible_,
                  builder: (context, snapshot) => Visibility(
                      visible: vm.wordTargetIsVisible,
                      child: StreamBuilder(
                          stream: vm.wordTargetString_,
                          builder: (context, snapshot) => Text(
                              vm.wordTargetString,
                              style: TextStyle(
                                  color: Colors.orange, fontSize: 50))))),
              StreamBuilder(
                  stream: vm.noteTargetIsVisible_,
                  builder: (context, snapshot) => Visibility(
                      visible: vm.noteTargetIsVisible,
                      child: StreamBuilder(
                          stream: vm.noteTargetString_,
                          builder: (context, snapshot) => Text(
                              vm.noteTargetString,
                              style: TextStyle(
                                  color: Colors.purpleAccent, fontSize: 40))))),
              StreamBuilder(
                  stream: vm.translationString_,
                  builder: (context, snapshot) => Text(vm.translationString)),
              StreamBuilder(
                  stream: vm.wordInputString_,
                  builder: (context, snapshot) => TextField(
                        style: TextStyle(fontSize: 60),
                        onChanged: vm.wordInputString_,
                      ))
            ],
          ),
        )
      ]));

  void more() async {
    final result = await Navigator.of(context).push<bool>(MaterialPageRoute(
        builder: (context) => ReviewOptionsPage(vm.options),
        fullscreenDialog: true));
    if (result == true) vm.newTest();
  }
}
