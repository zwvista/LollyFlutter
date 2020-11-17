import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WordsDictPage extends StatefulWidget {
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
            Expanded(flex: 2, child: DropdownButton()),
            Expanded(flex: 1, child: DropdownButton())
          ]),
        ],
      ),
    );
  }
}
