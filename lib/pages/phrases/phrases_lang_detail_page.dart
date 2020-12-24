import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lolly_flutter/models/wpp/mlangphrase.dart';
import 'package:lolly_flutter/viewmodels/phrases/phrases_lang_detail_viewmodel.dart';
import 'package:lolly_flutter/viewmodels/phrases/phrases_lang_viewmodel.dart';

class PhrasesLangDetailPage extends StatefulWidget {
  PhrasesLangDetailViewModel vmDetail;

  PhrasesLangDetailPage(PhrasesLangViewModel vm, MLangPhrase item) {
    vmDetail = PhrasesLangDetailViewModel(vm, item);
  }

  @override
  PhrasesLangDetailPageState createState() =>
      PhrasesLangDetailPageState(vmDetail);
}

class PhrasesLangDetailPageState extends State<PhrasesLangDetailPage> {
  final _formKey = GlobalKey<FormState>();
  final PhrasesLangDetailViewModel vmDetail;
  MLangPhrase get item => vmDetail.item;

  PhrasesLangDetailPageState(this.vmDetail);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Phrases in Lang(Detail)')),
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
                        initialValue: item.phrase,
                        decoration: InputDecoration(
                          labelText: "PHRASE",
                        ),
                        onSaved: (s) => item.phrase = s),
                    TextFormField(
                        initialValue: item.translation,
                        decoration: InputDecoration(
                          labelText: "NOTE",
                        ),
                        onSaved: (s) => item.translation = s),
                    RaisedButton(
                        color: Colors.blueAccent,
                        onPressed: () {
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
