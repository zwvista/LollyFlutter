import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lolly_flutter/models/wpp/munitword.dart';
import 'package:lolly_flutter/viewmodels/words/words_unit_detail_viewmodel.dart';
import 'package:lolly_flutter/viewmodels/words/words_unit_viewmodel.dart';

class WordsTextbookDetailPage extends StatefulWidget {
  final WordsUnitDetailViewModel vmDetail;

  WordsTextbookDetailPage(WordsUnitViewModel vm, MUnitWord item, {super.key})
      : vmDetail = WordsUnitDetailViewModel(vm, item);

  @override
  WordsTextbookDetailPageState createState() => WordsTextbookDetailPageState();
}

class WordsTextbookDetailPageState extends State<WordsTextbookDetailPage> {
  final _formKey = GlobalKey<FormState>();
  MUnitWord get item => widget.vmDetail.item;

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Words in Textbook(Detail)'), actions: [
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
                  initialValue: item.wordid.toString(),
                  decoration: const InputDecoration(
                    labelText: "WORDID",
                  ),
                  readOnly: true,
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
                  readOnly: true,
                ),
                TextFormField(
                  initialValue: item.accuracy,
                  decoration: const InputDecoration(
                    labelText: "ACCURACY",
                  ),
                  readOnly: true,
                ),
              ]))));
}
