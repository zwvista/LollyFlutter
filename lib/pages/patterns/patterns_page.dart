import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lolly_flutter/pages/patterns/patterns_detail_page.dart';
import 'package:lolly_flutter/pages/patterns/patterns_webpages_page.dart';
import 'package:lolly_flutter/services/misc/base_service.dart';
import 'package:lolly_flutter/viewmodels/misc/settings_viewmodel.dart';
import 'package:lolly_flutter/viewmodels/patterns/patterns_viewmodel.dart';
import 'package:rx_widgets/rx_widgets.dart';

import '../../keys.dart';

class PatternsPage extends StatefulWidget {
  @override
  PatternsPageState createState() => PatternsPageState();
}

class PatternsPageState extends State<PatternsPage> {
  final vm = PatternsViewModel();

  PatternsPageState();

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(children: [
                Expanded(
                  child: TextField(
                    autocorrect: false,
                    decoration: InputDecoration(
                      hintText: "Filter",
                    ),
                    onChanged: vm.textFilterChangedCommand,
                  ),
                ),
                StreamBuilder(
                    stream: vm.scopeFilterChangedCommand,
                    builder: (context, snapshot) => DropdownButton(
                          value: vm.scopeFilter,
                          items: SettingsViewModel.scopePatternFilters
                              .map((s) =>
                                  DropdownMenuItem(value: s, child: Text(s)))
                              .toList(),
                          onChanged: vm.scopeFilterChangedCommand,
                        ))
              ])),
          Expanded(
            child: RxLoader(
              spinnerKey: AppKeys.loadingSpinner,
              radius: 25.0,
              commandResults: vm.filterCommand.results,
              dataBuilder: (context, data) => ListView.separated(
                itemCount: vm.lstPatterns.length,
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (BuildContext context, int index) {
                  void edit() => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          PatternsDetailPage(vm, vm.lstPatterns[index])));

                  final entry = vm.lstPatterns[index];
                  return Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.25,
                    child: Container(
                        color: Colors.white,
                        child: ListTile(
                          title: Text(
                            entry.pattern,
                            style:
                                TextStyle(fontSize: 20, color: Colors.orange),
                          ),
                          subtitle: Text(entry.tags,
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
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        PatternsWebPagesPage(
                                                            vm.lstPatterns[
                                                                index])));
                                          }),
                                      SimpleDialogOption(
                                          child: Text("Copy Pattern"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                            vm.lstPatterns[index].pattern
                                                .copyToClipboard();
                                          }),
                                      SimpleDialogOption(
                                          child: Text("Google Pattern"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                            vm.lstPatterns[index].pattern
                                                .google();
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
      );
}
