import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lolly_flutter/models/wpp/munitword.dart';
import 'package:lolly_flutter/viewmodels/words/words_unit_detail_viewmodel.dart';
import 'package:lolly_flutter/viewmodels/words/words_unit_viewmodel.dart';

class WordsUnitDetailPage extends StatefulWidget {
  final WordsUnitDetailViewModel vmDetail;

  WordsUnitDetailPage(WordsUnitViewModel vm, MUnitWord item, {super.key})
      : vmDetail = WordsUnitDetailViewModel(vm, item);

  @override
  WordsUnitDetailPageState createState() => WordsUnitDetailPageState();
}

class WordsUnitDetailPageState extends State<WordsUnitDetailPage> {
  final _formKey = GlobalKey<FormState>();
  MUnitWord get item => widget.vmDetail.item;

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Words in Unit(Detail)'), actions: [
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.white,
          ),
          onPressed: () async {
            if (!_formKey.currentState!.validate()) return;
            _formKey.currentState!.save();
            await widget.vmDetail.save();
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
                  enabled: false,
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
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onSaved: (s) => item.seqnum = int.parse(s!),
                ),
                TextFormField(
                  initialValue: item.wordid.toString(),
                  decoration: const InputDecoration(
                    labelText: "WORDID",
                  ),
                  enabled: false,
                ),
                TextFormField(
                    initialValue: item.word,
                    decoration: const InputDecoration(
                      labelText: "WORD",
                    ),
                    validator: (v) =>
                        v!.isEmpty ? "WORD must not be empty" : null,
                    onSaved: (s) => item.word = s!),
                TextFormField(
                    initialValue: item.note,
                    decoration: const InputDecoration(
                      labelText: "NOTE",
                    ),
                    onSaved: (s) => item.note = s!),
                TextFormField(
                  initialValue: item.famiid.toString(),
                  decoration: const InputDecoration(
                    labelText: "FAMIID",
                  ),
                  enabled: false,
                ),
                TextFormField(
                  initialValue: item.accuracy,
                  decoration: const InputDecoration(
                    labelText: "ACCURACY",
                  ),
                  enabled: false,
                )
              ]))));
}
