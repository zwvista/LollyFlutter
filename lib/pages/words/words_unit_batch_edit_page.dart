import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lolly_flutter/viewmodels/words/words_unit_batch_edit_viewmodel.dart';
import 'package:lolly_flutter/viewmodels/words/words_unit_viewmodel.dart';

import '../../main.dart';

class WordsUnitBatchEditPage extends StatefulWidget {
  final WordsUnitBatchEditViewModel vmBatch;

  WordsUnitBatchEditPage(WordsUnitViewModel vm, {super.key})
      : vmBatch = WordsUnitBatchEditViewModel(vm);

  @override
  WordsUnitBatchEditPageState createState() => WordsUnitBatchEditPageState();
}

class WordsUnitBatchEditPageState extends State<WordsUnitBatchEditPage> {
  WordsUnitBatchEditViewModel get vmBatch => widget.vmBatch;

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Words in Unit(Batch Edit)'), actions: [
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Save"),
        )
      ]),
      body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              StreamBuilder(
                  stream: vmBatch.unitChecked,
                  builder: (context, snapshot) => Row(children: [
                        SizedBox(
                            height: 24.0,
                            width: 30.0,
                            child: Checkbox(
                                value: vmBatch.unitChecked.lastResult,
                                onChanged: vmBatch.unitChecked.call)),
                        Expanded(
                            child: DropdownButtonFormField(
                                value: vmBatch.unit.lastResult,
                                decoration: const InputDecoration(
                                  labelText: "UNIT",
                                ),
                                items: vmSettings.selectedTextbook!.lstUnits
                                    .map((o) => DropdownMenuItem(
                                        value: o.value, child: Text(o.label)))
                                    .toList(),
                                onChanged: (vmBatch.unitChecked.lastResult!
                                    ? vmBatch.unit
                                    : null) as void Function(int?)?))
                      ])),
              StreamBuilder(
                  stream: vmBatch.partChecked,
                  builder: (context, snapshot) => Row(children: [
                        SizedBox(
                            height: 24.0,
                            width: 30.0,
                            child: Checkbox(
                                value: vmBatch.partChecked.lastResult,
                                onChanged: vmBatch.partChecked.call)),
                        Expanded(
                            child: DropdownButtonFormField(
                                value: vmBatch.part.lastResult,
                                decoration: const InputDecoration(
                                  labelText: "PART",
                                ),
                                items: vmSettings.selectedTextbook!.lstParts
                                    .map((o) => DropdownMenuItem(
                                        value: o.value, child: Text(o.label)))
                                    .toList(),
                                onChanged: (vmBatch.partChecked.lastResult!
                                    ? vmBatch.part
                                    : null) as void Function(int?)?))
                      ])),
              StreamBuilder(
                  stream: vmBatch.seqnumChecked,
                  builder: (context, snapshot) => Row(children: [
                        SizedBox(
                            height: 24.0,
                            width: 30.0,
                            child: Checkbox(
                                value: vmBatch.seqnumChecked.lastResult,
                                onChanged: vmBatch.seqnumChecked.call)),
                        Expanded(
                            child: TextFormField(
                                initialValue: vmBatch.seqnum.lastResult,
                                decoration: const InputDecoration(
                                  labelText: "SEQNUM(+)",
                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                readOnly: !vmBatch.seqnumChecked.lastResult!,
                                onChanged: vmBatch.seqnum.call))
                      ])),
              StreamBuilder(
                  stream: vmBatch.selectedItemsCmd,
                  builder: (context, snapshot) => Expanded(
                      child: ListView.separated(
                          itemCount: vmBatch.vm.lstUnitWords.length,
                          separatorBuilder: (context, index) => const Divider(),
                          itemBuilder: (BuildContext context, int index) {
                            final entry = vmBatch.vm.lstUnitWords[index];
                            return ListTile(
                              leading: Column(children: [
                                Text(entry.unitstr,
                                    style: const TextStyle(color: Colors.blue)),
                                Text(entry.partstr,
                                    style: const TextStyle(color: Colors.blue)),
                                Text(entry.seqnum.toString(),
                                    style: const TextStyle(color: Colors.blue))
                              ]),
                              title: Text(
                                entry.word,
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.orange),
                              ),
                              subtitle: Text(entry.note,
                                  style: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Color.fromARGB(255, 255, 0, 255),
                                  )),
                              trailing: Visibility(
                                  visible:
                                      vmBatch.selectedItems.contains(entry),
                                  child: const Icon(Icons.favorite,
                                      color: Colors.red, size: 30.0)),
                              onTap: () => vmBatch.selectedItemsCmd(entry),
                            );
                          })))
            ],
          )));
}
