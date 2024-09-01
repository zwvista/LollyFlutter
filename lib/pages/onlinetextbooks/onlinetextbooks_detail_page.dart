import 'package:flutter/material.dart';
import 'package:lolly_flutter/models/misc/monlinetextbook.dart';
import 'package:lolly_flutter/viewmodels/onlinetextbooks/onlinetextbooks_detail_viewmodel.dart';

class OnlineTextbooksDetailPage extends StatefulWidget {
  final OnlineTextbooksDetailViewModel vmDetail;

  OnlineTextbooksDetailPage(MOnlineTextbook item, {super.key})
      : vmDetail = OnlineTextbooksDetailViewModel(item);

  @override
  OnlineTextbooksDetailPageState createState() =>
      OnlineTextbooksDetailPageState();
}

class OnlineTextbooksDetailPageState extends State<OnlineTextbooksDetailPage> {
  final _formKey = GlobalKey<FormState>();
  MOnlineTextbook get item => widget.vmDetail.item;

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Online Textbooks (Detail)')),
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
