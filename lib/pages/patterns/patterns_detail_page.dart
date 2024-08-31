import 'package:flutter/material.dart';
import 'package:lolly_flutter/models/wpp/mpattern.dart';
import 'package:lolly_flutter/viewmodels/patterns/patterns_detail_viewmodel.dart';
import 'package:lolly_flutter/viewmodels/patterns/patterns_viewmodel.dart';

class PatternsDetailPage extends StatefulWidget {
  final PatternsDetailViewModel vmDetail;

  PatternsDetailPage(PatternsViewModel vm, MPattern item, {super.key})
      : vmDetail = PatternsDetailViewModel(item);

  @override
  PatternsDetailPageState createState() => PatternsDetailPageState();
}

class PatternsDetailPageState extends State<PatternsDetailPage> {
  final _formKey = GlobalKey<FormState>();
  MPattern get item => widget.vmDetail.item;

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar:
          AppBar(title: const Text('Patterns in Language(Detail)'), actions: [
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
                    initialValue: item.pattern,
                    decoration: const InputDecoration(
                      labelText: "PATTERN",
                    )),
                TextFormField(
                    initialValue: item.tags,
                    decoration: const InputDecoration(
                      labelText: "TAGS",
                    )),
                TextFormField(
                    initialValue: item.title,
                    decoration: const InputDecoration(
                      labelText: "TITLE",
                    )),
                TextFormField(
                    initialValue: item.url,
                    decoration: const InputDecoration(
                      labelText: "URL",
                    )),
              ]))));
}
