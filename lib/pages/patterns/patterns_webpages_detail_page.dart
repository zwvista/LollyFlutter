import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lolly_flutter/models/wpp/mpatternwebpage.dart';
import 'package:lolly_flutter/viewmodels/patterns/patterns_webpages_detail_viewmodel.dart';
import 'package:lolly_flutter/viewmodels/patterns/patterns_webpages_viewmodel.dart';

class PatternsWebPagesDetailPage extends StatefulWidget {
  PatternsWebPagesDetailViewModel vmDetail;

  PatternsWebPagesDetailPage(
      PatternsWebPagesViewModel vm, MPatternWebPage item) {
    vmDetail = PatternsWebPagesDetailViewModel(vm, item);
  }

  @override
  PatternsWebPagesDetailPageState createState() =>
      PatternsWebPagesDetailPageState(vmDetail);
}

class PatternsWebPagesDetailPageState
    extends State<PatternsWebPagesDetailPage> {
  final _formKey = GlobalKey<FormState>();
  final PatternsWebPagesDetailViewModel vmDetail;
  MPatternWebPage get item => vmDetail.item;

  PatternsWebPagesDetailPageState(this.vmDetail);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Patterns Web Pages(Detail)')),
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
                        onSaved: (s) => item.seqnum = int.parse(s)),
                    TextFormField(
                        initialValue: item.webpageid.toString(),
                        decoration: InputDecoration(
                          labelText: "WEBPAGEID",
                        ),
                        enabled: false,
                        onSaved: (s) => item.webpageid = int.parse(s)),
                    TextFormField(
                        initialValue: item.title.toString(),
                        decoration: InputDecoration(
                          labelText: "TITLE",
                        ),
                        validator: (v) =>
                            v.isEmpty ? "TITLE must not be empty" : null,
                        onSaved: (s) => item.title = s),
                    TextFormField(
                        initialValue: item.url.toString(),
                        decoration: InputDecoration(
                          labelText: "URL",
                        ),
                        validator: (v) =>
                            v.isEmpty ? "URL must not be empty" : null,
                        onSaved: (s) => item.url = s),
                    RaisedButton(
                        color: Colors.blueAccent,
                        onPressed: () {
                          if (!_formKey.currentState.validate()) return;
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
