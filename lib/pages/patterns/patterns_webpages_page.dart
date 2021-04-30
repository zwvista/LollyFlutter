import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lolly_flutter/models/wpp/mpattern.dart';
import 'package:lolly_flutter/pages/patterns/patterns_webpages_detail_page.dart';
import 'package:lolly_flutter/viewmodels/patterns/patterns_webpages_viewmodel.dart';
import 'package:rx_widgets/rx_widgets.dart';

import '../../keys.dart';

class PatternsWebPagesPage extends StatefulWidget {
  final PatternsWebPagesViewModel vm;

  PatternsWebPagesPage(MPattern item) : vm = PatternsWebPagesViewModel(item);

  @override
  PatternsWebPagesPageState createState() => PatternsWebPagesPageState(vm);
}

class PatternsWebPagesPageState extends State<PatternsWebPagesPage> {
  final PatternsWebPagesViewModel vm;

  PatternsWebPagesPageState(this.vm);

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: Text('Patterns Web Pages')),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: RxLoader(
                  spinnerKey: AppKeys.loadingSpinner,
                  radius: 25.0,
                  commandResults: vm.reloadCommand.results,
                  dataBuilder: (context, data) => ListView.separated(
                    itemCount: vm.lstPatternsWebPages.length,
                    separatorBuilder: (context, index) => Divider(),
                    itemBuilder: (BuildContext context, int index) {
                      final entry = vm.lstPatternsWebPages[index];
                      void edit() =>
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  PatternsWebPagesDetailPage(vm, entry),
                              fullscreenDialog: true));

                      return Slidable(
                        actionPane: SlidableDrawerActionPane(),
                        actionExtentRatio: 0.25,
                        child: Container(
                            color: Colors.white,
                            child: ListTile(
                              title: Text(
                                entry.title,
                                style: TextStyle(
                                    fontSize: 20, color: Colors.orange),
                              ),
                              subtitle: Text(entry.url,
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Color.fromARGB(255, 255, 0, 255),
                                  )),
                            )),
                        actions: [
                          IconSlideAction(
                            caption: 'Edit',
                            color: Colors.blue,
                            icon: Icons.mode_edit,
                            onTap: () => edit(),
                          ),
                        ],
                        secondaryActions: [
                          IconSlideAction(
                              caption: 'More',
                              color: Colors.black45,
                              icon: Icons.more_horiz,
                              onTap: () => showDialog(
                                    context: context,
                                    builder: (context) => SimpleDialog(
                                        title: Text("More"),
                                        children: [
                                          SimpleDialogOption(
                                              child: Text("Delete"),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              }),
                                          SimpleDialogOption(
                                              child: Text("Edit"),
                                              onPressed: () {
                                                Navigator.pop(context);
                                                edit();
                                              }),
                                          SimpleDialogOption(
                                              child: Text("Browse Web Pages"),
                                              onPressed: () {
                                                Navigator.pop(context);
                                                edit();
                                              }),
                                          SimpleDialogOption(
                                              child: Text("Edit Web Pages"),
                                              onPressed: () {
                                                Navigator.pop(context);
                                                edit();
                                              }),
                                          SimpleDialogOption(
                                              child: Text("Copy Pattern"),
                                              onPressed: () {
                                                Navigator.pop(context);
                                                edit();
                                              }),
                                          SimpleDialogOption(
                                              child: Text("Google Pattern"),
                                              onPressed: () {
                                                Navigator.pop(context);
                                                edit();
                                              }),
                                        ]),
                                  )),
                          IconSlideAction(
                            caption: 'Delete',
                            color: Colors.red,
                            icon: Icons.delete,
                          ),
                        ],
                      );
                    },
                  ),
                  placeHolderBuilder: (context) => Center(
                      key: AppKeys.loaderPlaceHolder, child: Text("No Data")),
                  errorBuilder: (context, ex) => Center(
                      key: AppKeys.loaderError,
                      child: Text("Error: ${ex.toString()}")),
                ),
              ),
            ],
          )));
}
