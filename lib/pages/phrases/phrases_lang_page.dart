import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lolly_flutter/pages/phrases/phrases_lang_detail_page.dart';
import 'package:lolly_flutter/viewmodels/misc/settings_viewmodel.dart';
import 'package:lolly_flutter/viewmodels/phrases/phrases_lang_viewmodel.dart';
import 'package:rx_widgets/rx_widgets.dart';

import '../../keys.dart';

class PhrasesLangPage extends StatefulWidget {
  @override
  PhrasesLangPageState createState() => PhrasesLangPageState();
}

class PhrasesLangPageState extends State<PhrasesLangPage> {
  final vm = PhrasesLangViewModel();

  PhrasesLangPageState();

  @override
  Widget build(BuildContext context) {
    return Column(
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
                        items: SettingsViewModel.scopePhraseFilters
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
              itemCount: vm.lstLangPhrases.length,
              itemBuilder: (BuildContext context, int index) {
                final entry = vm.lstLangPhrases[index];
                return Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  actionExtentRatio: 0.25,
                  child: Container(
                      color: Colors.white,
                      child: ListTile(
                        title: Text(
                          entry.phrase,
                          style: TextStyle(fontSize: 20, color: Colors.orange),
                        ),
                        subtitle: Text(entry.translation,
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
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PhrasesLangDetailPage(
                              vm, vm.lstLangPhrases[index]))),
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