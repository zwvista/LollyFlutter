import 'package:flutter/material.dart';
import 'package:lolly_flutter/models/wpp/mlangword.dart';
import 'package:lolly_flutter/viewmodels/words/words_lang_detail_viewmodel.dart';
import 'package:lolly_flutter/viewmodels/words/words_lang_viewmodel.dart';

class WordsLangDetailPage extends StatefulWidget {
  final WordsLangDetailViewModel vmDetail;

  WordsLangDetailPage(WordsLangViewModel vm, MLangWord item, {super.key})
      : vmDetail = WordsLangDetailViewModel(vm, item);

  @override
  WordsLangDetailPageState createState() => WordsLangDetailPageState();
}

class WordsLangDetailPageState extends State<WordsLangDetailPage> {
  final _formKey = GlobalKey<FormState>();
  MLangWord get item => widget.vmDetail.item;

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Words in Language(Detail)'), actions: [
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.white,
          ),
          onPressed: () async {
            if (!_formKey.currentState!.validate()) return;
            _formKey.currentState!.save();
            await widget.vmDetail.save();
            if (!context.mounted) return;
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
