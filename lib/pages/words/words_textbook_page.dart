import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lolly_flutter/pages/words/words_dict_page.dart';
import 'package:lolly_flutter/pages/words/words_textbook_detail_page.dart';
import 'package:lolly_flutter/viewmodels/misc/settings_viewmodel.dart';
import 'package:lolly_flutter/viewmodels/words/words_unit_viewmodel.dart';
import 'package:rx_widgets/rx_widgets.dart';

import '../../keys.dart';
import '../../main.dart';

class WordsTextbookPage extends StatefulWidget {
  @override
  WordsTextbookPageState createState() => WordsTextbookPageState();
}

class WordsTextbookPageState extends State<WordsTextbookPage> {
  final vm = WordsUnitViewModel(false);

  WordsTextbookPageState();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: [
              Row(children: [
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
              ]),
              Row(children: [
                Expanded(
                  child: StreamBuilder(
                      stream: vm.textbookFilterChangedCommand,
                      builder: (context, snapshot) => DropdownButtonFormField(
                            value: vm.textbookFilter,
                            items: vmSettings.lstTextbookFilters
                                .map((o) => DropdownMenuItem(
                                    value: o.value, child: Text(o.label)))
                                .toList(),
                            onChanged: vm.textbookFilterChangedCommand,
                          )),
                )
              ])
            ])),
        Expanded(
          child: RxLoader(
            spinnerKey: AppKeys.loadingSpinner,
            radius: 25.0,
            commandResults: vm.filterCommand.results,
            dataBuilder: (context, data) => ListView.builder(
              itemCount: vm.lstUnitWords.length,
              itemBuilder: (BuildContext context, int index) {
                final entry = vm.lstUnitWords[index];
                return Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  actionExtentRatio: 0.25,
                  child: Container(
                    color: Colors.white,
                    child: ListTile(
                        leading: Column(children: <Widget>[
                          Text(entry.unitstr,
                              style: TextStyle(color: Colors.blue)),
                          Text(entry.partstr,
                              style: TextStyle(color: Colors.blue)),
                          Text(entry.seqnum.toString(),
                              style: TextStyle(color: Colors.blue))
                        ]),
                        title: Text(
                          entry.word,
                          style: TextStyle(fontSize: 20, color: Colors.orange),
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
                  ),
                  actions: [
                    IconSlideAction(
                      caption: 'Edit',
                      color: Colors.blue,
                      icon: Icons.mode_edit,
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => WordsTextbookDetailPage(
                              vm, vm.lstUnitWords[index]))),
                    ),
                  ],
                  secondaryActions: [
                    IconSlideAction(
                        caption: 'More',
                        color: Colors.black45,
                        icon: Icons.more_horiz,
                        onTap: () => showDialog(
                              context: context,
                              builder: (context) =>
                                  SimpleDialog(title: Text("More"), children: [
                                SimpleDialogOption(
                                    child: Text("Edit"),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    }),
                                SimpleDialogOption(
                                    child: Text("Delete"),
                                    onPressed: () {
                                      Navigator.pop(context);
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
            placeHolderBuilder: (context) =>
                Center(key: AppKeys.loaderPlaceHolder, child: Text("No Data")),
            errorBuilder: (context, ex) => Center(
                key: AppKeys.loaderError,
                child: Text("Error: ${ex.toString()}")),
          ),
        ),
      ],
    );
  }
}
