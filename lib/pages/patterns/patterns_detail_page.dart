import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lolly_flutter/models/wpp/mpattern.dart';
import 'package:lolly_flutter/viewmodels/patterns/patterns_detail_viewmodel.dart';
import 'package:lolly_flutter/viewmodels/patterns/patterns_viewmodel.dart';

class PatternsDetailPage extends StatefulWidget {
  PatternsDetailViewModel vmDetail;

  PatternsDetailPage(PatternsViewModel vm, MPattern item) {
    vmDetail = PatternsDetailViewModel(vm, item);
  }

  @override
  PatternsDetailPageState createState() => PatternsDetailPageState(vmDetail);
}

class PatternsDetailPageState extends State<PatternsDetailPage> {
  final _formKey = GlobalKey<FormState>();
  final PatternsDetailViewModel vmDetail;
  MPattern get item => vmDetail.item;

  PatternsDetailPageState(this.vmDetail);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Patterns in Language(Detail)')),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
                key: _formKey,
                child: ListView(
                  children: [
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
                        onSaved: (s) => item.pattern = s),
                    TextFormField(
                        initialValue: item.note,
                        decoration: InputDecoration(
                          labelText: "NOTE",
                        ),
                        onSaved: (s) => item.note = s),
                    TextFormField(
                        initialValue: item.tags,
                        decoration: InputDecoration(
                          labelText: "TAGS",
                        ),
                        onSaved: (s) => item.tags = s),
                    RaisedButton(
                        color: Colors.blueAccent,
                        onPressed: () {
                          _formKey.currentState.save();
                          Navigator.pop(context);
                        },
                        child: Text("Save",
                            style: TextStyle(
                              color: Colors.white,
                            ))),
                  ],
                ))));
  }
}
