import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
            Stack(
              children: [
                Text("Correct", style: TextStyle(color: Colors.green)),
                Text("Incorrect", style: TextStyle(color: Colors.pink))
              ],
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [TextButton(child: Text("Check"))],
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text("Word",
                  style: TextStyle(color: Colors.orange, fontSize: 50)),
              Text("Note",
                  style: TextStyle(color: Colors.purpleAccent, fontSize: 40)),
              Text("data"),
              TextField(style: TextStyle(fontSize: 60))
            ],
          ),
        )
      ]));
}
