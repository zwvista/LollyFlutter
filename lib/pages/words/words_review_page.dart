import 'package:flutter/material.dart';
import 'package:flutter_command/flutter_command.dart';
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
  final wordInputStringController = TextEditingController();

  @override
  void initState() {
    super.initState();
    vm = WordsReviewViewModel(() {
      if (vm.hasCurrent && vm.isSpeaking) speak(vm.currentWord);
    });
    Future.delayed(const Duration(seconds: 1), () => more());
    widget.vmHome.more = more;
    vm.wordInputString_.listen((v, _) => wordInputStringController.text = v);
  }

  @override
  void dispose() {
    vm.subscriptionTimer?.cancel();
    wordInputStringController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(children: [
        Row(
          children: [
            ValueListenableBuilder(
                valueListenable: vm.indexVisible_,
                builder: (context, value, _) => Visibility(
                    visible: vm.indexVisible,
                    child: ValueListenableBuilder(
                        valueListenable: vm.indexString_,
                        builder: (context, value, _) => Text(vm.indexString)))),
            Expanded(
                child: ValueListenableBuilder(
                    valueListenable: vm.accuracyVisible_,
                    builder: (context, value, _) => Visibility(
                        visible: vm.accuracyVisible,
                        child: ValueListenableBuilder(
                            valueListenable: vm.accuracyString_,
                            builder: (context, value, _) => Text(
                                vm.accuracyString,
                                textAlign: TextAlign.center))))),
            Stack(
              children: [
                ValueListenableBuilder(
                    valueListenable: vm.correctVisible_,
                    builder: (context, value, _) => Visibility(
                        visible: vm.correctVisible,
                        child: const Text("Correct",
                            style: TextStyle(color: Colors.green)))),
                ValueListenableBuilder(
                    valueListenable: vm.incorrectVisible_,
                    builder: (context, value, _) => Visibility(
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
            ValueListenableBuilder(
                valueListenable: vm.isSpeaking_,
                builder: (context, value, _) => Expanded(
                        child: CheckboxListTile(
                      title: const Text("Speak"),
                      value: vm.isSpeaking,
                      onChanged: vm.isSpeaking_.call,
                    ))),
            ValueListenableBuilder(
                valueListenable: vm.checkNextEnabled_,
                builder: (context, value, _) => ValueListenableBuilder(
                    valueListenable: vm.checkNextString_,
                    builder: (context, value, _) => TextButton(
                        onPressed:
                            !vm.checkNextEnabled ? null : () => vm.check(true),
                        child: Text(vm.checkNextString))))
          ],
        ),
        Row(
          children: [
            ValueListenableBuilder(
                valueListenable: vm.onRepeatVisible_,
                builder: (context, value, _) => Visibility(
                    visible: vm.onRepeatVisible,
                    child: ValueListenableBuilder(
                        valueListenable: vm.onRepeat_,
                        builder: (context, value, _) => Expanded(
                                child: CheckboxListTile(
                              title: const Text("On Repeat"),
                              value: vm.onRepeat,
                              onChanged: vm.onRepeat_.call,
                            ))))),
            ValueListenableBuilder(
                valueListenable: vm.moveForwardVisible_,
                builder: (context, value, _) => Visibility(
                    visible: vm.moveForwardVisible,
                    child: ValueListenableBuilder(
                        valueListenable: vm.moveForward_,
                        builder: (context, value, _) => Expanded(
                                child: CheckboxListTile(
                              title: const Text("Forward"),
                              value: vm.moveForward,
                              onChanged: vm.moveForward_.call,
                            ))))),
            ValueListenableBuilder(
                valueListenable: vm.checkPrevVisible_,
                builder: (context, value, _) => Visibility(
                    visible: vm.checkPrevVisible,
                    child: ValueListenableBuilder(
                        valueListenable: vm.checkPrevEnabled_,
                        builder: (context, value, _) => ValueListenableBuilder(
                            valueListenable: vm.checkPrevString_,
                            builder: (context, value, _) => TextButton(
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
              ValueListenableBuilder(
                  valueListenable: vm.wordTargetVisible_,
                  builder: (context, value, _) => Visibility(
                      visible: vm.wordTargetVisible,
                      child: ValueListenableBuilder(
                          valueListenable: vm.wordTargetString_,
                          builder: (context, value, _) => Center(
                                child: Text(vm.wordTargetString,
                                    style: const TextStyle(
                                        color: Colors.orange, fontSize: 50)),
                              )))),
              ValueListenableBuilder(
                  valueListenable: vm.noteTargetVisible_,
                  builder: (context, value, _) => Visibility(
                      visible: vm.noteTargetVisible,
                      child: ValueListenableBuilder(
                          valueListenable: vm.noteTargetString_,
                          builder: (context, value, _) => Center(
                                child: Text(vm.noteTargetString,
                                    style: const TextStyle(
                                        color: Colors.purpleAccent,
                                        fontSize: 40)),
                              )))),
              ValueListenableBuilder(
                  valueListenable: vm.wordHintVisible_,
                  builder: (context, value, _) => Visibility(
                      visible: vm.wordHintVisible,
                      child: ValueListenableBuilder(
                          valueListenable: vm.wordHintString_,
                          builder: (context, value, _) => Center(
                                child: Text(vm.wordHintString,
                                    style: const TextStyle(fontSize: 40)),
                              )))),
              ValueListenableBuilder(
                  valueListenable: vm.translationString_,
                  builder: (context, value, _) => Text(vm.translationString)),
              ValueListenableBuilder(
                  valueListenable: vm.wordInputString_,
                  builder: (context, value, _) => TextField(
                        controller: wordInputStringController,
                        style: const TextStyle(fontSize: 60),
                        textAlign: TextAlign.center,
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
