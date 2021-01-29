import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lolly_flutter/viewmodels/phrases/phrases_unit_batch_edit_viewmodel.dart';
import 'package:lolly_flutter/viewmodels/phrases/phrases_unit_viewmodel.dart';

class PhrasesUnitBatchEditPage extends StatefulWidget {
  final PhrasesUnitBatchEditViewModel vmBatch;

  PhrasesUnitBatchEditPage(PhrasesUnitViewModel vm)
      : vmBatch = PhrasesUnitBatchEditViewModel(vm);

  @override
  PhrasesUnitBatchEditPageState createState() =>
      PhrasesUnitBatchEditPageState();
}

class PhrasesUnitBatchEditPageState extends State<PhrasesUnitBatchEditPage> {
  final _formKey = GlobalKey<FormState>();
  PhrasesUnitBatchEditViewModel get vmBatch => widget.vmBatch;

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
                    Row(
                      children: [
                        DropdownButtonFormField(
                            value: vmBatch.unit,
                            items: vmBatch.textbook.lstUnits
                                .map((o) => DropdownMenuItem(
                                    value: o.value, child: Text(o.label)))
                                .toList(),
                            decoration: InputDecoration(
                              labelText: "UNIT",
                            ),
                            onChanged: (v) => v,
                            onSaved: (v) => vmBatch.unit = v),
                      ],
                    ),
                    DropdownButtonFormField(
                        value: vmBatch.part,
                        items: vmBatch.textbook.lstParts
                            .map((o) => DropdownMenuItem(
                                value: o.value, child: Text(o.label)))
                            .toList(),
                        decoration: InputDecoration(
                          labelText: "PART",
                        ),
                        onChanged: (v) => v,
                        onSaved: (v) => vmBatch.part = v),
                    TextFormField(
                      initialValue: vmBatch.seqnum.toString(),
                      decoration: InputDecoration(
                        labelText: "SEQNUM(+)",
                      ),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onSaved: (s) => vmBatch.seqnum = int.parse(s),
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
