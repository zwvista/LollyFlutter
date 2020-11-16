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
    return MaterialApp(
      title: 'Dictionary',
      theme: ThemeData(
          primarySwatch: Colors.blue, scaffoldBackgroundColor: Colors.white),
      home: Column(
        children: <Widget>[],
      ),
    );
  }
}
