import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lolly_flutter/viewmodels/phrases/phrases_unit_batch_edit_viewmodel.dart';
import 'package:lolly_flutter/viewmodels/phrases/phrases_unit_viewmodel.dart';

import '../../main.dart';

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
        appBar: AppBar(title: Text('Phrases in Unit(Batch Edit)'), actions: [
          TextButton(
            child: Text("Save"),
            style: TextButton.styleFrom(
              primary: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ]),
        body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                StreamBuilder(
                    stream: vmBatch.unitIsChecked,
                    builder: (context, snapshot) => Row(children: [
                          SizedBox(
                              height: 24.0,
                              width: 30.0,
                              child: Checkbox(
                                  value: vmBatch.unitIsChecked.lastResult,
                                  onChanged: vmBatch.unitIsChecked)),
                          Expanded(
                              child: DropdownButtonFormField(
                                  value: vmBatch.unit.lastResult,
                                  decoration: InputDecoration(
                                    labelText: "UNIT",
                                  ),
                                  items: vmSettings.selectedTextbook.lstUnits
                                      .map((o) => DropdownMenuItem(
                                          value: o.value, child: Text(o.label)))
                                      .toList(),
                                  onChanged: vmBatch.unitIsChecked.lastResult
                                      ? vmBatch.unit
                                      : null))
                        ])),
                StreamBuilder(
                    stream: vmBatch.partIsChecked,
                    builder: (context, snapshot) => Row(children: [
                          SizedBox(
                              height: 24.0,
                              width: 30.0,
                              child: Checkbox(
                                  value: vmBatch.partIsChecked.lastResult,
                                  onChanged: vmBatch.partIsChecked)),
                          Expanded(
                              child: DropdownButtonFormField(
                                  value: vmBatch.part.lastResult,
                                  decoration: InputDecoration(
                                    labelText: "PART",
                                  ),
                                  items: vmSettings.selectedTextbook.lstParts
                                      .map((o) => DropdownMenuItem(
                                          value: o.value, child: Text(o.label)))
                                      .toList(),
                                  onChanged: vmBatch.partIsChecked.lastResult
                                      ? vmBatch.part
                                      : null))
                        ])),
                StreamBuilder(
                    stream: vmBatch.seqnumIsChecked,
                    builder: (context, snapshot) => Row(children: [
                          SizedBox(
                              height: 24.0,
                              width: 30.0,
                              child: Checkbox(
                                  value: vmBatch.seqnumIsChecked.lastResult,
                                  onChanged: vmBatch.seqnumIsChecked)),
                          Expanded(
                              child: TextFormField(
                                  initialValue: vmBatch.seqnum.lastResult,
                                  decoration: InputDecoration(
                                    labelText: "SEQNUM(+)",
                                  ),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  readOnly: !vmBatch.seqnumIsChecked.lastResult,
                                  onChanged: vmBatch.seqnum))
                        ])),
              ],
            )));
  }
}
