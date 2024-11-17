import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lolly_flutter/viewmodels/phrases/phrases_unit_batch_edit_viewmodel.dart';
import 'package:lolly_flutter/viewmodels/phrases/phrases_unit_viewmodel.dart';

import '../../main.dart';

class PhrasesUnitBatchEditPage extends StatefulWidget {
  final PhrasesUnitBatchEditViewModel vmBatch;

  PhrasesUnitBatchEditPage(PhrasesUnitViewModel vm, {super.key})
      : vmBatch = PhrasesUnitBatchEditViewModel(vm);

  @override
  PhrasesUnitBatchEditPageState createState() =>
      PhrasesUnitBatchEditPageState();
}

class PhrasesUnitBatchEditPageState extends State<PhrasesUnitBatchEditPage> {
  PhrasesUnitBatchEditViewModel get vmBatch => widget.vmBatch;

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar:
          AppBar(title: const Text('Phrases in Unit(Batch Edit)'), actions: [
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
              ValueListenableBuilder(
                  valueListenable: vmBatch.unitChecked,
                  builder: (context, value, _) => Row(children: [
                        SizedBox(
                            height: 24.0,
                            width: 30.0,
                            child: Checkbox(
                                value: vmBatch.unitChecked.value,
                                onChanged: vmBatch.unitChecked.call)),
                        Expanded(
                            child: DropdownButtonFormField(
                                value: vmBatch.unit.value,
                                decoration: const InputDecoration(
                                  labelText: "UNIT",
                                ),
                                items: vmSettings.selectedTextbook!.lstUnits
                                    .map((o) => DropdownMenuItem(
                                        value: o.value, child: Text(o.label)))
                                    .toList(),
                                onChanged: (vmBatch.unitChecked.value
                                    ? vmBatch.unit
                                    : null) as void Function(int?)?))
                      ])),
              ValueListenableBuilder(
                  valueListenable: vmBatch.partChecked,
                  builder: (context, value, _) => Row(children: [
                        SizedBox(
                            height: 24.0,
                            width: 30.0,
                            child: Checkbox(
                                value: vmBatch.partChecked.value,
                                onChanged: vmBatch.partChecked.call)),
                        Expanded(
                            child: DropdownButtonFormField(
                                value: vmBatch.part.value,
                                decoration: const InputDecoration(
                                  labelText: "PART",
                                ),
                                items: vmSettings.selectedTextbook!.lstParts
                                    .map((o) => DropdownMenuItem(
                                        value: o.value, child: Text(o.label)))
                                    .toList(),
                                onChanged: (vmBatch.partChecked.value
                                    ? vmBatch.part
                                    : null) as void Function(int?)?))
                      ])),
              ValueListenableBuilder(
                  valueListenable: vmBatch.seqnumChecked,
                  builder: (context, value, _) => Row(children: [
                        SizedBox(
                            height: 24.0,
                            width: 30.0,
                            child: Checkbox(
                                value: vmBatch.seqnumChecked.value,
                                onChanged: vmBatch.seqnumChecked.call)),
                        Expanded(
                            child: TextFormField(
                                initialValue: vmBatch.seqnum.value,
                                decoration: const InputDecoration(
                                  labelText: "SEQNUM(+)",
                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                readOnly: !vmBatch.seqnumChecked.value,
                                onChanged: vmBatch.seqnum.call))
                      ])),
              ValueListenableBuilder(
                  valueListenable: vmBatch.selectedItemsCmd,
                  builder: (context, value, _) => Expanded(
                      child: ListView.separated(
                          itemCount: vmBatch.vm.lstUnitPhrases.length,
                          separatorBuilder: (context, index) => const Divider(),
                          itemBuilder: (BuildContext context, int index) {
                            final entry = vmBatch.vm.lstUnitPhrases[index];
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
                                entry.phrase,
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.orange),
                              ),
                              subtitle: Text(entry.translation,
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
