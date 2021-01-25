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
  WordsLangDetailPageState createState() => WordsLangDetailPageState(vmDetail);
}

class WordsLangDetailPageState extends State<WordsLangDetailPage> {
  final _formKey = GlobalKey<FormState>();
  final WordsLangDetailViewModel vmDetail;
  MLangWord get item => vmDetail.item;

  WordsLangDetailPageState(this.vmDetail);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Words in Language(Detail)')),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
                key: _formKey,
                child: ListView(
                  children: [
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
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blueAccent),
                        onPressed: () {
                          if (!_formKey.currentState.validate()) return;
                          _formKey.currentState.save();
                          Navigator.pop(context);
                        },
                        child: Text("Save",
                            style: TextStyle(
                              color: Colors.white,
                            ))),
                  ],
                ))));
  }
}
