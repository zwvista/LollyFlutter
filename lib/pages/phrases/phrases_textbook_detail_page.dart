import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lolly_flutter/models/wpp/munitphrase.dart';
import 'package:lolly_flutter/viewmodels/phrases/phrases_unit_detail_viewmodel.dart';
import 'package:lolly_flutter/viewmodels/phrases/phrases_unit_viewmodel.dart';

class PhrasesTextbookDetailPage extends StatefulWidget {
  final PhrasesUnitDetailViewModel vmDetail;

  PhrasesTextbookDetailPage(PhrasesUnitViewModel vm, MUnitPhrase item,
      {super.key})
      : vmDetail = PhrasesUnitDetailViewModel(vm, item);

  @override
  PhrasesTextbookDetailPageState createState() =>
      PhrasesTextbookDetailPageState();
}

class PhrasesTextbookDetailPageState extends State<PhrasesTextbookDetailPage> {
  final _formKey = GlobalKey<FormState>();
  MUnitPhrase get item => widget.vmDetail.item;

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar:
          AppBar(title: const Text('Phrases in Textbook(Detail)'), actions: [
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.white,
          ),
          onPressed: () {
            if (!_formKey.currentState!.validate()) return;
            _formKey.currentState!.save();
            Navigator.pop(context);
          },
          child: const Text("Save"),
        )
      ]),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
              key: _formKey,
              child: ListView(children: [
                TextFormField(
                  initialValue: item.id.toString(),
                  decoration: const InputDecoration(
                    labelText: "ID",
                  ),
                  readOnly: true,
                ),
                TextFormField(
                  initialValue: item.textbookname,
                  decoration: const InputDecoration(
                    labelText: "TEXTBOOK",
                  ),
                  readOnly: true,
                ),
                DropdownButtonFormField(
                    value: item.unit,
                    items: item.textbook!.lstUnits
                        .map((o) => DropdownMenuItem(
                            value: o.value, child: Text(o.label)))
                        .toList(),
                    decoration: const InputDecoration(
                      labelText: "UNIT",
                    ),
                    onChanged: (v) => v,
                    onSaved: (v) => item.unit = v as int),
                DropdownButtonFormField(
                    value: item.part,
                    items: item.textbook!.lstParts
                        .map((o) => DropdownMenuItem(
                            value: o.value, child: Text(o.label)))
                        .toList(),
                    decoration: const InputDecoration(
                      labelText: "PART",
                    ),
                    onChanged: (v) => v,
                    onSaved: (v) => item.part = v as int),
                TextFormField(
                  initialValue: item.seqnum.toString(),
                  decoration: const InputDecoration(
                    labelText: "SEQNUM",
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onSaved: (s) => item.seqnum = int.parse(s!),
                ),
                TextFormField(
                  initialValue: item.phraseid.toString(),
                  decoration: const InputDecoration(
                    labelText: "PHRASEID",
                  ),
                  readOnly: true,
                ),
                TextFormField(
                    initialValue: item.phrase,
                    decoration: const InputDecoration(
                      labelText: "PHRASE",
                    ),
                    validator: (v) =>
                        v!.isEmpty ? "PHRASE must not be empty" : null,
                    onSaved: (s) => item.phrase = s!),
                TextFormField(
                    initialValue: item.translation,
                    decoration: const InputDecoration(
                      labelText: "NOTE",
                    ),
                    onSaved: (s) => item.translation = s!),
              ]))));
}
