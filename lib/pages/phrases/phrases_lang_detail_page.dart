import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lolly_flutter/models/wpp/mlangphrase.dart';
import 'package:lolly_flutter/viewmodels/phrases/phrases_lang_detail_viewmodel.dart';
import 'package:lolly_flutter/viewmodels/phrases/phrases_lang_viewmodel.dart';

class PhrasesLangDetailPage extends StatefulWidget {
  final PhrasesLangDetailViewModel vmDetail;

  PhrasesLangDetailPage(PhrasesLangViewModel vm, MLangPhrase item)
      : vmDetail = PhrasesLangDetailViewModel(vm, item);

  @override
  PhrasesLangDetailPageState createState() => PhrasesLangDetailPageState();
}

class PhrasesLangDetailPageState extends State<PhrasesLangDetailPage> {
  final _formKey = GlobalKey<FormState>();
  MLangPhrase get item => widget.vmDetail.item;

  @override
  Widget build(BuildContext context) =>
     Scaffold(
        appBar: AppBar(title: Text('Phrases in Language(Detail)'), actions: [
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
                      initialValue: item.phrase,
                      decoration: InputDecoration(
                        labelText: "PHRASE",
                      ),
                      validator: (v) =>
                          v.isEmpty ? "PHRASE must not be empty" : null,
                      onSaved: (s) => item.phrase = s),
                  TextFormField(
                      initialValue: item.translation,
                      decoration: InputDecoration(
                        labelText: "NOTE",
                      ),
                      onSaved: (s) => item.translation = s),
                ]))));
}
