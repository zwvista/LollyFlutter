import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lolly_flutter/pages/words/wordsdictpage.dart';
import 'package:lolly_flutter/viewmodels/misc/settingsviewmodel.dart';
import 'package:lolly_flutter/viewmodels/words/wordslangviewmodel.dart';
import 'package:rx_widgets/rx_widgets.dart';

import '../../keys.dart';

class WordsLangPage extends StatefulWidget {
  @override
  WordsLangPageState createState() => WordsLangPageState();
}

class WordsLangPageState extends State<WordsLangPage> {
  final vm = WordsLangViewModel();

  WordsLangPageState();

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
              itemCount: vm.lstLangWords.length,
              itemBuilder: (BuildContext context, int index) {
                final entry = vm.lstLangWords[index];
                return Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  actionExtentRatio: 0.25,
                  child: Container(
                    color: Colors.white,
                    child: ListTile(
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
                                        vm.lstLangWords
                                            .map((e) => e.word)
                                            .toList(),
                                        index))))),
                  ),
                  actions: [
                    IconSlideAction(
                      caption: 'Edit',
                      color: Colors.blue,
                      icon: Icons.mode_edit,
                    ),
                  ],
                  secondaryActions: [
                    IconSlideAction(
                      caption: 'More',
                      color: Colors.black45,
                      icon: Icons.more_horiz,
                    ),
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
