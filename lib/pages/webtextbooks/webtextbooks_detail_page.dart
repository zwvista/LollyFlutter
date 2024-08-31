import 'package:flutter/material.dart';
import 'package:lolly_flutter/models/misc/mwebtextbook.dart';
import 'package:lolly_flutter/viewmodels/webtextbooks/webtextbooks_detail_viewmodel.dart';

class WebTextbooksDetailPage extends StatefulWidget {
  final WebTextbooksDetailViewModel vmDetail;

  WebTextbooksDetailPage(MWebTextbook item, {super.key})
      : vmDetail = WebTextbooksDetailViewModel(item);

  @override
  WebTextbooksDetailPageState createState() => WebTextbooksDetailPageState();
}

class WebTextbooksDetailPageState extends State<WebTextbooksDetailPage> {
  final _formKey = GlobalKey<FormState>();
  MWebTextbook get item => widget.vmDetail.item;

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('WebTextbooks(Detail)')),
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
                TextFormField(
                  initialValue: item.unit.toString(),
                  decoration: const InputDecoration(
                    labelText: "UNIT",
                  ),
                  readOnly: true,
                ),
                TextFormField(
                  initialValue: item.title,
                  decoration: const InputDecoration(
                    labelText: "TITLE",
                  ),
                  readOnly: true,
                ),
                TextFormField(
                  initialValue: item.url,
                  decoration: const InputDecoration(
                    labelText: "URL",
                  ),
                  readOnly: true,
                ),
              ]))));
}
