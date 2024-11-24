import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lolly_flutter/pages/phrases/phrases_textbook_detail_page.dart';
import 'package:lolly_flutter/services/misc/base_service.dart';
import 'package:lolly_flutter/viewmodels/misc/settings_viewmodel.dart';
import 'package:lolly_flutter/viewmodels/phrases/phrases_unit_viewmodel.dart';

import '../../main.dart';

class PhrasesTextbookPage extends StatefulWidget {
  const PhrasesTextbookPage({super.key});

  @override
  PhrasesTextbookPageState createState() => PhrasesTextbookPageState();
}

class PhrasesTextbookPageState extends State<PhrasesTextbookPage> {
  final vm = PhrasesUnitViewModel(false);

  PhrasesTextbookPageState() {
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
                      decoration: const InputDecoration(
                        hintText: "Filter",
                      ),
                      onChanged: vm.textFilter_.call,
                    ),
                  ),
                  ValueListenableBuilder(
                      valueListenable: vm.scopeFilter_,
                      builder: (context, value, _) => DropdownButton(
                            value: vm.scopeFilter,
                            items: SettingsViewModel.scopePhraseFilters
                                .map((s) =>
                                    DropdownMenuItem(value: s, child: Text(s)))
                                .toList(),
                            onChanged: vm.scopeFilter_.call,
                          ))
                ]),
                Row(children: [
                  Expanded(
                    child: ValueListenableBuilder(
                        valueListenable: vm.textbookFilter_,
                        builder: (context, value, _) => DropdownButtonFormField(
                              value: vm.textbookFilter,
                              items: vmSettings.lstTextbookFilters
                                  .map((o) => DropdownMenuItem(
                                      value: o.value, child: Text(o.label)))
                                  .toList(),
                              onChanged: vm.textbookFilter_.call,
                            )),
                  )
                ])
              ])),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: vm.reloadCommand,
              builder: (context, data, _) => ListView.separated(
                itemCount: vm.lstUnitPhrases.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (BuildContext context, int index) {
                  final entry = vm.lstUnitPhrases[index];
                  void edit() => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PhrasesTextbookDetailPage(vm, entry),
                          fullscreenDialog: true));

                  return Slidable(
                    startActionPane: ActionPane(
                      motion: const DrawerMotion(),
                      extentRatio: 0.25,
                      children: [
                        SlidableAction(
                          label: 'Edit',
                          backgroundColor: Colors.blue,
                          icon: Icons.mode_edit,
                          onPressed: (context) => edit(),
                        ),
                      ],
                    ),
                    endActionPane: ActionPane(
                      motion: const DrawerMotion(),
                      extentRatio: 0.25,
                      children: [
                        SlidableAction(
                            label: 'More',
                            backgroundColor: Colors.black45,
                            icon: Icons.more_horiz,
                            onPressed: (context) => showDialog(
                                  context: context,
                                  builder: (context) => SimpleDialog(
                                      title: const Text("More"),
                                      children: [
                                        SimpleDialogOption(
                                            child: const Text("Edit"),
                                            onPressed: () {
                                              Navigator.pop(context);
                                              edit();
                                            }),
                                        SimpleDialogOption(
                                            child: const Text("Delete"),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            }),
                                        SimpleDialogOption(
                                            child: const Text("Copy Phrase"),
                                            onPressed: () {
                                              Navigator.pop(context);
                                              vm.lstUnitPhrases[index].phrase
                                                  .copyToClipboard();
                                            }),
                                        SimpleDialogOption(
                                            child: const Text("Google Phrase"),
                                            onPressed: () {
                                              Navigator.pop(context);
                                              vm.lstUnitPhrases[index].phrase
                                                  .google();
                                            }),
                                      ]),
                                )),
                        SlidableAction(
                          label: 'Delete',
                          backgroundColor: Colors.red,
                          icon: Icons.delete,
                          onPressed: (context) {},
                        ),
                      ],
                    ),
                    child: Container(
                        color: Colors.white,
                        child: ListTile(
                          leading: Column(children: <Widget>[
                            Text(entry.unitstr,
                                style: const TextStyle(color: Colors.blue)),
                            Text(entry.partstr,
                                style: const TextStyle(color: Colors.blue)),
                            Text(entry.seqnum.toString(),
                                style: const TextStyle(color: Colors.blue))
                          ]),
                          title: Text(
                            entry.phrase,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.orange),
                          ),
                          subtitle: Text(entry.translation,
                              style: const TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Color.fromARGB(255, 255, 0, 255),
                              )),
                          onTap: () {
                            speak(entry.phrase);
                          },
                        )),
                  );
                },
              ),
            ),
          ),
        ],
      );
}
