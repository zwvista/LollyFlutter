import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lolly_flutter/viewmodels/words/words_unit_batch_edit_viewmodel.dart';
import 'package:lolly_flutter/viewmodels/words/words_unit_viewmodel.dart';

import '../../main.dart';

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
                StreamBuilder(
                    stream: vmBatch.selectedItemsCmd,
                    builder: (context, snapshot) => Expanded(
                        child: ListView.separated(
                            itemCount: vmBatch.vm.lstUnitWords.length,
                            separatorBuilder: (context, index) => Divider(),
                            itemBuilder: (BuildContext context, int index) {
                              final entry = vmBatch.vm.lstUnitWords[index];
                              return ListTile(
                                leading: Column(children: [
                                  Text(entry.unitstr,
                                      style: TextStyle(color: Colors.blue)),
                                  Text(entry.partstr,
                                      style: TextStyle(color: Colors.blue)),
                                  Text(entry.seqnum.toString(),
                                      style: TextStyle(color: Colors.blue))
                                ]),
                                title: Text(
                                  entry.word,
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.orange),
                                ),
                                subtitle: Text(entry.note,
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: Color.fromARGB(255, 255, 0, 255),
                                    )),
                                trailing: Visibility(
                                    child: Icon(Icons.favorite,
                                        color: Colors.red, size: 30.0),
                                    visible:
                                        vmBatch.selectedItems.contains(entry)),
                                onTap: () =>
                                    vmBatch.selectedItemsCmd.execute(entry),
                              );
                            })))
              ],
            )));
  }
}
