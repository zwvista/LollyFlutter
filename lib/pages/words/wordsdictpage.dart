import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WordsDictPage extends StatefulWidget {
  List<String> lstWords;
  int currentWordIndex;
  WordsDictPage(this.lstWords, this.currentWordIndex);
  @override
  WordsDictPageState createState() {
    return WordsDictPageState();
  }
}

class WordsDictPageState extends State<WordsDictPage> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dictionary')),
      body: Column(
        children: <Widget>[
          Row(children: <Widget>[
            Expanded(
                child: DropdownButton(
              value: widget.lstWords[widget.currentWordIndex],
              items: widget.lstWords
                  .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                  .toList(),
              onChanged: (String value) {},
            )),
            Expanded(
                child: DropdownButton(
              onChanged: (value) {},
            ))
          ]),
        ],
      ),
    );
  }
}
