import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lolly_flutter/viewmodels/phrases/phrases_review_viewmodel.dart';

class PhrasesReviewPage extends StatefulWidget {
  final state = _PhrasesReviewPageState();
  @override
  _PhrasesReviewPageState createState() => state;
}

class _PhrasesReviewPageState extends State<PhrasesReviewPage> {
  final vm = PhrasesReviewViewModel(() {});

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
            Expanded(child: Text("data", textAlign: TextAlign.center)),
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
                  stream: vm.phraseTargetVisible_,
                  builder: (context, snapshot) => Visibility(
                      visible: vm.phraseTargetVisible,
                      child: StreamBuilder(
                          stream: vm.phraseTargetString_,
                          builder: (context, snapshot) => Text(
                              vm.phraseTargetString,
                              style: TextStyle(
                                  color: Colors.orange, fontSize: 50))))),
              StreamBuilder(
                  stream: vm.translationString_,
                  builder: (context, snapshot) => Text(vm.translationString,
                      style:
                          TextStyle(color: Colors.purpleAccent, fontSize: 40))),
              StreamBuilder(
                  stream: vm.phraseInputString_,
                  builder: (context, snapshot) => TextField(
                        style: TextStyle(fontSize: 60),
                        onChanged: vm.phraseInputString_,
                      ))
            ],
          ),
        )
      ]));

  void more() {}
}
