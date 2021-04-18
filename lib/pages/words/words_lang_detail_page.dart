import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lolly_flutter/models/wpp/mlangword.dart';
import 'package:lolly_flutter/viewmodels/words/words_lang_detail_viewmodel.dart';
import 'package:lolly_flutter/viewmodels/words/words_lang_viewmodel.dart';

class WordsLangDetailPage extends StatefulWidget {
  final WordsLangDetailViewModel vmDetail;

  WordsLangDetailPage(WordsLangViewModel vm, MLangWord item)
      : vmDetail = WordsLangDetailViewModel(vm, item);

  @override
  WordsLangDetailPageState createState() => WordsLangDetailPageState();
}

class WordsLangDetailPageState extends State<WordsLangDetailPage> {
  final _formKey = GlobalKey<FormState>();
  MLangWord get item => widget.vmDetail.item;

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: Text('Words in Language(Detail)'), actions: [
        TextButton(
          child: Text("Save"),
          style: TextButton.styleFrom(
            primary: Colors.white,
          ),
          onPressed: () async {
            if (!_formKey.currentState.validate()) return;
            _formKey.currentState.save();
            await widget.vmDetail.save();
            Navigator.pop(context);
          },
        )
      ]),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
              key: _formKey,
              child: ListView(children: [
                TextFormField(
                  initialValue: item.id.toString(),
                  decoration: InputDecoration(
                    labelText: "ID",
                  ),
                  enabled: false,
                ),
                TextFormField(
                    initialValue: item.word,
                    decoration: InputDecoration(
                      labelText: "WORD",
                    ),
                    validator: (v) =>
                        v.isEmpty ? "WORD must not be empty" : null,
                    onSaved: (s) => item.word = s),
                TextFormField(
                    initialValue: item.note,
                    decoration: InputDecoration(
                      labelText: "NOTE",
                    ),
                    onSaved: (s) => item.note = s),
                TextFormField(
                  initialValue: item.famiid.toString(),
                  decoration: InputDecoration(
                    labelText: "FAMIID",
                  ),
                  enabled: false,
                ),
                TextFormField(
                  initialValue: item.accuracy,
                  decoration: InputDecoration(
                    labelText: "ACCURACY",
                  ),
                  enabled: false,
                ),
              ]))));
}
