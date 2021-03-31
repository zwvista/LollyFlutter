import 'package:flutter/cupertino.dart';

class WordsReviewPage extends StatefulWidget {
  @override
  _WordsReviewPageState createState() => _WordsReviewPageState();
}

class _WordsReviewPageState extends State<WordsReviewPage> {
  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(children: [
        Row(
          children: [
            Text("data"),
            Expanded(child: Text("data", textAlign: TextAlign.center)),
            Text("data")
          ],
        ),
        Row(
          children: [],
        ),
        Expanded(
            child: Column(
          children: [],
        ))
      ]));
}
