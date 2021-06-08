import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lolly_flutter/models/wpp/mpatternwebpage.dart';
import 'package:lolly_flutter/viewmodels/patterns/patterns_webpages_detail_viewmodel.dart';
import 'package:lolly_flutter/viewmodels/patterns/patterns_webpages_viewmodel.dart';

class PatternsWebPagesDetailPage extends StatefulWidget {
  final PatternsWebPagesDetailViewModel vmDetail;

  PatternsWebPagesDetailPage(PatternsWebPagesViewModel vm, MPatternWebPage item)
      : vmDetail = PatternsWebPagesDetailViewModel(vm, item);

  @override
  PatternsWebPagesDetailPageState createState() =>
      PatternsWebPagesDetailPageState();
}

class PatternsWebPagesDetailPageState
    extends State<PatternsWebPagesDetailPage> {
  final _formKey = GlobalKey<FormState>();
  MPatternWebPage get item => widget.vmDetail.item;

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: Text('Patterns Web Pages(Detail)'), actions: [
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
                  enabled: false,
                ),
                TextFormField(
                  initialValue: item.patternid.toString(),
                  decoration: InputDecoration(
                    labelText: "PATTERNID",
                  ),
                  enabled: false,
                ),
                TextFormField(
                    initialValue: item.seqnum.toString(),
                    decoration: InputDecoration(
                      labelText: "SEQNUM",
                    ),
                    onSaved: (s) => item.seqnum = int.parse(s!)),
                TextFormField(
                    initialValue: item.webpageid.toString(),
                    decoration: InputDecoration(
                      labelText: "WEBPAGEID",
                    ),
                    enabled: false,
                    onSaved: (s) => item.webpageid = int.parse(s!)),
                TextFormField(
                    initialValue: item.title.toString(),
                    decoration: InputDecoration(
                      labelText: "TITLE",
                    ),
                    validator: (v) =>
                        v!.isEmpty ? "TITLE must not be empty" : null,
                    onSaved: (s) => item.title = s!),
                TextFormField(
                    initialValue: item.url.toString(),
                    decoration: InputDecoration(
                      labelText: "URL",
                    ),
                    validator: (v) =>
                        v!.isEmpty ? "URL must not be empty" : null,
                    onSaved: (s) => item.url = s!),
              ]))));
}
