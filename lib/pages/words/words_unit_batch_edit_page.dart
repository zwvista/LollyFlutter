import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lolly_flutter/models/wpp/munitword.dart';
import 'package:lolly_flutter/viewmodels/words/words_unit_batch_edit_viewmodel.dart';
import 'package:lolly_flutter/viewmodels/words/words_unit_viewmodel.dart';

class WordsUnitBatchEditPage extends StatefulWidget {
  final WordsUnitBatchEditViewModel vmBatch;

  WordsUnitBatchEditPage(WordsUnitViewModel vm)
      : vmBatch = WordsUnitBatchEditViewModel(vm);

  @override
  WordsUnitBatchEditPageState createState() => WordsUnitBatchEditPageState();
}

class WordsUnitBatchEditPageState extends State<WordsUnitBatchEditPage> {
  final _formKey = GlobalKey<FormState>();
  final item = MUnitWord();

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
                        labelText: "SEQNUM(+)",
                      ),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onSaved: (s) => item.seqnum = int.parse(s),
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
