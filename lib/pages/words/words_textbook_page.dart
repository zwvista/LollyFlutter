import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lolly_flutter/pages/words/words_dict_page.dart';
import 'package:lolly_flutter/pages/words/words_textbook_detail_page.dart';
import 'package:lolly_flutter/services/misc/base_service.dart';
import 'package:lolly_flutter/viewmodels/misc/settings_viewmodel.dart';
import 'package:lolly_flutter/viewmodels/words/words_unit_viewmodel.dart';
import 'package:rx_widgets/rx_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../keys.dart';
import '../../main.dart';

class WordsTextbookPage extends StatefulWidget {
  final state = WordsTextbookPageState();
  @override
  WordsTextbookPageState createState() => state;
}

class WordsTextbookPageState extends State<WordsTextbookPage> {
  final vm = WordsUnitViewModel(false);

  WordsTextbookPageState() {
    vm.reloaded = false;
    vm.reloadCommand();
  }

  @override
  Widget build(BuildContext context) => Column(
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
                      onChanged: vm.textFilter_,
                    ),
                  ),
                  StreamBuilder(
                      stream: vm.scopeFilter_,
                      builder: (context, snapshot) => DropdownButton(
                            value: vm.scopeFilter,
                            items: SettingsViewModel.scopeWordFilters
                                .map((s) =>
                                    DropdownMenuItem(value: s, child: Text(s)))
                                .toList(),
                            onChanged: vm.scopeFilter_,
                          ))
                ]),
                Row(children: [
                  Expanded(
                    child: StreamBuilder(
                        stream: vm.textbookFilter_,
                        builder: (context, snapshot) => DropdownButtonFormField(
                              value: vm.textbookFilter,
                              items: vmSettings.lstTextbookFilters
                                  .map((o) => DropdownMenuItem(
                                      value: o.value, child: Text(o.label)))
                                  .toList(),
                              onChanged: vm.textbookFilter_,
                            )),
                  )
                ])
              ])),
          Expanded(
            child: RxLoader(
              spinnerKey: AppKeys.loadingSpinner,
              radius: 25.0,
              commandResults: vm.reloadCommand.results,
              dataBuilder: (context, data) => ListView.separated(
                itemCount: vm.lstUnitWords.length,
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (BuildContext context, int index) {
                  void edit() => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          WordsTextbookDetailPage(vm, vm.lstUnitWords[index]),
                      fullscreenDialog: true));

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
                                          index)))),
                          onTap: () {
                            speak(entry.word);
                          },
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
