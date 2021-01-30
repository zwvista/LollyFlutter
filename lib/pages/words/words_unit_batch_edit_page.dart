import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  WordsUnitBatchEditViewModel get vmBatch => widget.vmBatch;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Words in Unit(Batch Edit)'), actions: [
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
                Row(children: [
                  SizedBox(
                      height: 24.0,
                      width: 30.0,
                      child: Checkbox(
                          value: vmBatch.unitIsChecked,
                          onChanged: (v) => vmBatch.unitIsChecked = v)),
                  Expanded(
                    child: DropdownButtonFormField(
                        value: vmBatch.unit,
                        decoration: InputDecoration(
                          labelText: "UNIT",
                        ),
                        items: vmBatch.textbook.lstUnits
                            .map((o) => DropdownMenuItem(
                                value: o.value, child: Text(o.label)))
                            .toList(),
                        onChanged: (v) => vmBatch.unit = v),
                  )
                ]),
                Row(children: [
                  SizedBox(
                      height: 24.0,
                      width: 30.0,
                      child: Checkbox(
                          value: vmBatch.partIsChecked,
                          onChanged: (v) => vmBatch.partIsChecked = v)),
                  Expanded(
                    child: DropdownButtonFormField(
                        value: vmBatch.part,
                        decoration: InputDecoration(
                          labelText: "PART",
                        ),
                        items: vmBatch.textbook.lstParts
                            .map((o) => DropdownMenuItem(
                                value: o.value, child: Text(o.label)))
                            .toList(),
                        onChanged: (v) => vmBatch.part = v),
                  )
                ]),
                Row(children: [
                  SizedBox(
                      height: 24.0,
                      width: 30.0,
                      child: Checkbox(
                          value: vmBatch.seqnumIsChecked,
                          onChanged: (v) => vmBatch.seqnumIsChecked = v)),
                  Expanded(
                      child: TextFormField(
                    initialValue: vmBatch.seqnum.toString(),
                    decoration: InputDecoration(
                      labelText: "SEQNUM(+)",
                    ),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (s) => vmBatch.seqnum = int.parse(s),
                  ))
                ]),
              ],
            )));
  }
}
