import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lolly_flutter/pages/phrases/phrases_lang_detail_page.dart';
import 'package:lolly_flutter/services/misc/base_service.dart';
import 'package:lolly_flutter/viewmodels/misc/settings_viewmodel.dart';
import 'package:lolly_flutter/viewmodels/phrases/phrases_lang_viewmodel.dart';
import 'package:rx_widgets/rx_widgets.dart';

import '../../keys.dart';
import '../../main.dart';

class PhrasesLangPage extends StatefulWidget {
  final state = PhrasesLangPageState();
  @override
  PhrasesLangPageState createState() => state;
}

class PhrasesLangPageState extends State<PhrasesLangPage> {
  final vm = PhrasesLangViewModel();

  PhrasesLangPageState() {
    vm.reloaded = false;
    vm.reloadCommand();
  }

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
                    onChanged: vm.textFilter_,
                  ),
                ),
                StreamBuilder(
                    stream: vm.scopeFilter_,
                    builder: (context, snapshot) => DropdownButton(
                          value: vm.scopeFilter,
                          items: SettingsViewModel.scopePhraseFilters
                              .map((s) =>
                                  DropdownMenuItem(value: s, child: Text(s)))
                              .toList(),
                          onChanged: vm.scopeFilter_,
                        ))
              ])),
          Expanded(
            child: RxLoader(
              spinnerKey: AppKeys.loadingSpinner,
              radius: 25.0,
              commandResults: vm.reloadCommand.results,
              dataBuilder: (context, data) => ListView.separated(
                itemCount: vm.lstLangPhrases.length,
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (BuildContext context, int index) {
                  final entry = vm.lstLangPhrases[index];
                  void edit() => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          PhrasesLangDetailPage(vm, vm.lstLangPhrases[index]),
                      fullscreenDialog: true));

                  return Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.25,
                    child: Container(
                        color: Colors.white,
                        child: ListTile(
                          title: Text(
                            entry.phrase,
                            style:
                                TextStyle(fontSize: 20, color: Colors.orange),
                          ),
                          subtitle: Text(entry.translation,
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Color.fromARGB(255, 255, 0, 255),
                              )),
                          onTap: () {
                            speak(entry.phrase);
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
                                          child: Text("Edit"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                            edit();
                                          }),
                                      SimpleDialogOption(
                                          child: Text("Delete"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          }),
                                      SimpleDialogOption(
                                          child: Text("Copy Phrase"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                            vm.lstLangPhrases[index].phrase
                                                .copyToClipboard();
                                          }),
                                      SimpleDialogOption(
                                          child: Text("Google Phrase"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                            vm.lstLangPhrases[index].phrase
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

  void more() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PhrasesLangDetailPage(vm, vm.newLangPhrase())));
  }
}
