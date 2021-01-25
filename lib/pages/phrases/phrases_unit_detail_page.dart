import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lolly_flutter/models/wpp/munitphrase.dart';
import 'package:lolly_flutter/viewmodels/phrases/phrases_unit_detail_viewmodel.dart';
import 'package:lolly_flutter/viewmodels/phrases/phrases_unit_viewmodel.dart';

class PhrasesUnitDetailPage extends StatefulWidget {
  final PhrasesUnitDetailViewModel vmDetail;

  PhrasesUnitDetailPage(PhrasesUnitViewModel vm, MUnitPhrase item)
      : vmDetail = PhrasesUnitDetailViewModel(vm, item);

  @override
  PhrasesUnitDetailPageState createState() => PhrasesUnitDetailPageState();
}

class PhrasesUnitDetailPageState extends State<PhrasesUnitDetailPage> {
  final _formKey = GlobalKey<FormState>();
  MUnitPhrase get item => widget.vmDetail.item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Phrases in Unit(Detail)')),
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
                      initialValue: item.phraseid.toString(),
                      decoration: InputDecoration(
                        labelText: "PHRASEID",
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
