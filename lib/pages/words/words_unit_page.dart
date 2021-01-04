import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lolly_flutter/pages/words/words_dict_page.dart';
import 'package:lolly_flutter/pages/words/words_unit_detail_page.dart';
import 'package:lolly_flutter/services/misc/base_service.dart';
import 'package:lolly_flutter/viewmodels/misc/settings_viewmodel.dart';
import 'package:lolly_flutter/viewmodels/words/words_unit_viewmodel.dart';
import 'package:rx_widgets/rx_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../keys.dart';
import '../../main.dart';

class WordsUnitPage extends StatefulWidget {
  @override
  WordsUnitPageState createState() => WordsUnitPageState();
}

class WordsUnitPageState extends State<WordsUnitPage> {
  final vm = WordsUnitViewModel(true);

  WordsUnitPageState();

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
                          items: SettingsViewModel.scopeWordFilters
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
              dataBuilder: (context, data) => ListView.builder(
                itemCount: vm.lstUnitWords.length,
                itemBuilder: (BuildContext context, int index) {
                  void edit() => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          WordsUnitDetailPage(vm, vm.lstUnitWords[index])));

                  final entry = vm.lstUnitWords[index];
                  return Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.25,
                    child: Column(children: [
                      ListTile(
                          leading: Column(children: [
                            Text(entry.unitstr,
                                style: TextStyle(color: Colors.blue)),
                            Text(entry.partstr,
                                style: TextStyle(color: Colors.blue)),
                            Text(entry.seqnum.toString(),
                                style: TextStyle(color: Colors.blue))
                          ]),
                          title: Text(
                            entry.word,
                            style:
                                TextStyle(fontSize: 20, color: Colors.orange),
                          ),
                          subtitle: Text(entry.note,
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Color.fromARGB(255, 255, 0, 255),
                              )),
                          trailing: IconButton(
                              icon: Icon(Icons.keyboard_arrow_right,
                                  color: Colors.blue, size: 30.0),
                              onPressed: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => WordsDictPage(
                                          vm.lstUnitWords
                                              .map((e) => e.word)
                                              .toList(),
                                          index))))),
                      Divider()
                    ]),
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
                                          child: Text("Retrieve Note"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                            edit();
                                          }),
                                      SimpleDialogOption(
                                          child: Text("Clear Note"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                            edit();
                                          }),
                                      SimpleDialogOption(
                                          child: Text("Copy Word"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                            vm.lstUnitWords[index].word
                                                .copyToClipboard();
                                          }),
                                      SimpleDialogOption(
                                          child: Text("Google Word"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                            vm.lstUnitWords[index].word
                                                .google();
                                          }),
                                      SimpleDialogOption(
                                          child: Text("Online Dictionary"),
                                          onPressed: () async {
                                            Navigator.pop(context);
                                            final url = vmSettings
                                                .selectedDictReference
                                                .urlString(
                                                    vm.lstUnitWords[index].word,
                                                    vmSettings.lstAutoCorrect);
                                            await launch(url);
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
