import 'package:flutter/material.dart';
import 'package:lolly_flutter/pages/misc/review_options_page.dart';
import 'package:lolly_flutter/viewmodels/words/words_review_viewmodel.dart';

import '../../main.dart';
import '../../viewmodels/misc/home_viewmodel.dart';

class WordsReviewPage extends StatefulWidget {
  final HomeViewModel vmHome;
  const WordsReviewPage(this.vmHome, {super.key});

  @override
  WordsReviewPageState createState() => WordsReviewPageState();
}

class WordsReviewPageState extends State<WordsReviewPage> {
  late WordsReviewViewModel vm;

  @override
  void initState() {
    super.initState();
    vm = WordsReviewViewModel(() {
      if (vm.hasCurrent && vm.isSpeaking) speak(vm.currentWord);
    });
    Future.delayed(const Duration(seconds: 1), () => more());
    widget.vmHome.more = more;
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
                        child: const Text("Correct",
                            style: TextStyle(color: Colors.green)))),
                StreamBuilder(
                    stream: vm.incorrectVisible_,
                    builder: (context, snapshot) => Visibility(
                        visible: vm.incorrectVisible,
                        child: const Text("Incorrect",
                            style: TextStyle(color: Colors.pink))))
              ],
            )
          ],
        ),
        Row(
          children: [
            TextButton(child: const Text("Speak"), onPressed: () {}),
            StreamBuilder(
                stream: vm.isSpeaking_,
                builder: (context, snapshot) => Expanded(
                        child: CheckboxListTile(
                      title: const Text("Speak"),
                      value: vm.isSpeaking,
                      onChanged: vm.isSpeaking_.call,
                    ))),
            StreamBuilder(
                stream: vm.checkNextEnabled_,
                builder: (context, snapshot) => StreamBuilder(
                    stream: vm.checkNextString_,
                    builder: (context, snapshot) => TextButton(
                        onPressed:
                            !vm.checkNextEnabled ? null : () => vm.check(true),
                        child: Text(vm.checkNextString))))
          ],
        ),
        Row(
          children: [
            StreamBuilder(
                stream: vm.onRepeatVisible_,
                builder: (context, snapshot) => Visibility(
                    visible: vm.onRepeatVisible,
                    child: StreamBuilder(
                        stream: vm.onRepeat_,
                        builder: (context, snapshot) => Expanded(
                                child: CheckboxListTile(
                              title: const Text("On Repeat"),
                              value: vm.onRepeat,
                              onChanged: vm.onRepeat_.call,
                            ))))),
            StreamBuilder(
                stream: vm.moveForwardVisible_,
                builder: (context, snapshot) => Visibility(
                    visible: vm.moveForwardVisible,
                    child: StreamBuilder(
                        stream: vm.moveForward_,
                        builder: (context, snapshot) => Expanded(
                                child: CheckboxListTile(
                              title: const Text("Forward"),
                              value: vm.moveForward,
                              onChanged: vm.moveForward_.call,
                            ))))),
            StreamBuilder(
                stream: vm.checkPrevVisible_,
                builder: (context, snapshot) => Visibility(
                    visible: vm.checkPrevVisible,
                    child: StreamBuilder(
                        stream: vm.checkPrevEnabled_,
                        builder: (context, snapshot) => StreamBuilder(
                            stream: vm.checkPrevString_,
                            builder: (context, snapshot) => TextButton(
                                onPressed: !vm.checkPrevEnabled
                                    ? null
                                    : () => vm.check(false),
                                child: Text(vm.checkPrevString))))))
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
                                    style: const TextStyle(
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
                                    style: const TextStyle(
                                        color: Colors.purpleAccent,
                                        fontSize: 40)),
                              )))),
              StreamBuilder(
                  stream: vm.translationString_,
                  builder: (context, snapshot) => Text(vm.translationString)),
              StreamBuilder(
                  stream: vm.wordInputString_,
                  builder: (context, snapshot) => TextField(
                        style: const TextStyle(fontSize: 60),
                        onChanged: vm.wordInputString_.call,
                      ))
            ],
          ),
        )
      ]));

  void more() async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ReviewOptionsPage(vm.options),
            fullscreenDialog: true));
    if (result == true) vm.newTest();
  }
}
