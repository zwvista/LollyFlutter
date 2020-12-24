import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lolly_flutter/models/wpp/munitword.dart';
import 'package:lolly_flutter/viewmodels/words/words_unit_detail_viewmodel.dart';
import 'package:lolly_flutter/viewmodels/words/words_unit_viewmodel.dart';

class WordsTextbookDetailPage extends StatefulWidget {
  WordsUnitDetailViewModel vmDetail;

  WordsTextbookDetailPage(WordsUnitViewModel vm, MUnitWord item) {
    vmDetail = WordsUnitDetailViewModel(vm, item);
  }

  @override
  WordsTextbookDetailPageState createState() =>
      WordsTextbookDetailPageState(vmDetail);
}

class WordsTextbookDetailPageState extends State<WordsTextbookDetailPage> {
  final _formKey = GlobalKey<FormState>();
  final WordsUnitDetailViewModel vmDetail;
  MUnitWord get item => vmDetail.item;

  WordsTextbookDetailPageState(this.vmDetail);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Words in Unit(Detail)')),
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
                    DropdownButtonFormField(
                        value: item.unit,
                        items: item.textbook.lstUnits
                            .map((o) => DropdownMenuItem(
                                value: o.value, child: Text(o.label)))
                            .toList(),
                        decoration: InputDecoration(
                          labelText: "UNIT",
                        ),
                        onChanged: (v) => v,
                        onSaved: (v) => item.unit = v),
                    DropdownButtonFormField(
                        value: item.part,
                        items: item.textbook.lstParts
                            .map((o) => DropdownMenuItem(
                                value: o.value, child: Text(o.label)))
                            .toList(),
                        decoration: InputDecoration(
                          labelText: "PART",
                        ),
                        onChanged: (v) => v,
                        onSaved: (v) => item.part = v),
                    TextFormField(
                      initialValue: item.seqnum.toString(),
                      decoration: InputDecoration(
                        labelText: "SEQNUM",
                      ),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onSaved: (s) => item.seqnum = int.parse(s),
                    ),
                    TextFormField(
                      initialValue: item.wordid.toString(),
                      decoration: InputDecoration(
                        labelText: "WORDID",
                      ),
                      enabled: false,
                    ),
                    TextFormField(
                        initialValue: item.word,
                        decoration: InputDecoration(
                          labelText: "WORD",
                        ),
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
