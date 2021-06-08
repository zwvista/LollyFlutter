import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lolly_flutter/models/wpp/mpattern.dart';
import 'package:lolly_flutter/viewmodels/patterns/patterns_detail_viewmodel.dart';
import 'package:lolly_flutter/viewmodels/patterns/patterns_viewmodel.dart';

class PatternsDetailPage extends StatefulWidget {
  final PatternsDetailViewModel vmDetail;

  PatternsDetailPage(PatternsViewModel vm, MPattern item)
      : vmDetail = PatternsDetailViewModel(vm, item);

  @override
  PatternsDetailPageState createState() => PatternsDetailPageState();
}

class PatternsDetailPageState extends State<PatternsDetailPage> {
  final _formKey = GlobalKey<FormState>();
  MPattern get item => widget.vmDetail.item;

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: Text('Patterns in Language(Detail)'), actions: [
        TextButton(
          child: Text("Save"),
          style: TextButton.styleFrom(
            primary: Colors.white,
          ),
          onPressed: () {
            if (!_formKey.currentState!.validate()) return;
            _formKey.currentState!.save();
            Navigator.pop(context);
          },
        )
      ]),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
              key: _formKey,
              child: ListView(children: [
                TextFormField(
                  initialValue: item.id.toString(),
                  decoration: InputDecoration(
                    labelText: "ID",
                  ),
                  enabled: false,
                ),
                TextFormField(
                    initialValue: item.pattern,
                    decoration: InputDecoration(
                      labelText: "PATTERN",
                    ),
                    validator: (v) =>
                        v!.isEmpty ? "PATTERN must not be empty" : null,
                    onSaved: (s) => item.pattern = s!),
                TextFormField(
                    initialValue: item.note,
                    decoration: InputDecoration(
                      labelText: "NOTE",
                    ),
                    onSaved: (s) => item.note = s!),
                TextFormField(
                    initialValue: item.tags,
                    decoration: InputDecoration(
                      labelText: "TAGS",
                    ),
                    onSaved: (s) => item.tags = s!),
              ]))));
}
