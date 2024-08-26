import 'package:flutter/material.dart';
import 'package:lolly_flutter/models/wpp/mlangphrase.dart';
import 'package:lolly_flutter/viewmodels/phrases/phrases_lang_detail_viewmodel.dart';
import 'package:lolly_flutter/viewmodels/phrases/phrases_lang_viewmodel.dart';

class PhrasesLangDetailPage extends StatefulWidget {
  final PhrasesLangDetailViewModel vmDetail;

  PhrasesLangDetailPage(PhrasesLangViewModel vm, MLangPhrase item, {super.key})
      : vmDetail = PhrasesLangDetailViewModel(vm, item);

  @override
  PhrasesLangDetailPageState createState() => PhrasesLangDetailPageState();
}

class PhrasesLangDetailPageState extends State<PhrasesLangDetailPage> {
  final _formKey = GlobalKey<FormState>();
  MLangPhrase get item => widget.vmDetail.item;

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar:
          AppBar(title: const Text('Phrases in Language(Detail)'), actions: [
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
                  enabled: false,
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
