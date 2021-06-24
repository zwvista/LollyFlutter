import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lolly_flutter/pages/misc/review_options_page.dart';
import 'package:lolly_flutter/viewmodels/words/words_review_viewmodel.dart';

import '../../main.dart';

class WordsReviewPage extends StatefulWidget {
  final state = _WordsReviewPageState();
  @override
  _WordsReviewPageState createState() => state;
}

class _WordsReviewPageState extends State<WordsReviewPage> {
  late WordsReviewViewModel vm;

  _WordsReviewPageState() {
    vm = WordsReviewViewModel(() {
      if (vm.hasCurrent && vm.isSpeaking) speak(vm.currentWord);
    });
    Future.delayed(Duration(seconds: 1), () => more());
  }

  @override
  void dispose() {
    vm.subscriptionTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(children: [
        Row(
          children: [
            StreamBuilder(
                stream: vm.indexVisible_,
                builder: (context, snapshot) => Visibility(
                    visible: vm.indexVisible,
                    child: StreamBuilder(
                        stream: vm.indexString_,
                        builder: (context, snapshot) => Text(vm.indexString)))),
            Expanded(
                child: StreamBuilder(
                    stream: vm.accuracyVisible_,
                    builder: (context, snapshot) => Visibility(
                        visible: vm.accuracyVisible,
                        child: StreamBuilder(
                            stream: vm.accuracyString_,
                            builder: (context, snapshot) => Text(
                                vm.accuracyString,
                                textAlign: TextAlign.center))))),
            Stack(
              children: [
                StreamBuilder(
                    stream: vm.correctVisible_,
                    builder: (context, snapshot) => Visibility(
                        visible: vm.correctVisible,
                        child: Text("Correct",
                            style: TextStyle(color: Colors.green)))),
                StreamBuilder(
                    stream: vm.incorrectVisible_,
                    builder: (context, snapshot) => Visibility(
                        visible: vm.incorrectVisible,
                        child: Text("Incorrect",
                            style: TextStyle(color: Colors.pink))))
              ],
            )
          ],
        ),
        Row(
          children: [
            TextButton(child: Text("Speak"), onPressed: () {}),
            StreamBuilder(
                stream: vm.isSpeaking_,
                builder: (context, snapshot) => Expanded(
                        child: CheckboxListTile(
                      title: Text("Speak"),
                      value: vm.isSpeaking,
                      onChanged: vm.isSpeaking_,
                    ))),
            StreamBuilder(
                stream: vm.checkNextEnabled_,
                builder: (context, snapshot) => StreamBuilder(
                    stream: vm.checkNextString_,
                    builder: (context, snapshot) => TextButton(
                        child: Text(vm.checkNextString),
                        onPressed: !vm.checkNextEnabled
                            ? null
                            : () => vm.check(true))))
          ],
        ),
        Row(
          children: [
            StreamBuilder(
                stream: vm.onRepeat_,
                builder: (context, snapshot) => Expanded(
                        child: CheckboxListTile(
                      title: Text("On Repeat"),
                      value: vm.onRepeat,
                      onChanged: vm.onRepeat_,
                    ))),
            StreamBuilder(
                stream: vm.moveForward_,
                builder: (context, snapshot) => Expanded(
                        child: CheckboxListTile(
                      title: Text("Forward"),
                      value: vm.moveForward,
                      onChanged: vm.moveForward_,
                    ))),
            StreamBuilder(
                stream: vm.checkPrevEnabled_,
                builder: (context, snapshot) => StreamBuilder(
                    stream: vm.checkPrevString_,
                    builder: (context, snapshot) => TextButton(
                        child: Text(vm.checkPrevString),
                        onPressed: !vm.checkPrevEnabled
                            ? null
                            : () => vm.check(false))))
          ],
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              StreamBuilder(
                  stream: vm.wordTargetVisible_,
                  builder: (context, snapshot) => Visibility(
                      visible: vm.wordTargetVisible,
                      child: StreamBuilder(
                          stream: vm.wordTargetString_,
                          builder: (context, snapshot) => Center(
                                child: Text(vm.wordTargetString,
                                    style: TextStyle(
                                        color: Colors.orange, fontSize: 50)),
                              )))),
              StreamBuilder(
                  stream: vm.noteTargetVisible_,
                  builder: (context, snapshot) => Visibility(
                      visible: vm.noteTargetVisible,
                      child: StreamBuilder(
                          stream: vm.noteTargetString_,
                          builder: (context, snapshot) => Center(
                                child: Text(vm.noteTargetString,
                                    style: TextStyle(
                                        color: Colors.purpleAccent,
                                        fontSize: 40)),
                              )))),
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
