import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lolly_flutter/pages/words/words_dict_page.dart';
import 'package:lolly_flutter/pages/words/words_textbook_detail_page.dart';
import 'package:lolly_flutter/services/misc/base_service.dart';
import 'package:lolly_flutter/viewmodels/misc/settings_viewmodel.dart';
import 'package:lolly_flutter/viewmodels/words/words_unit_viewmodel.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../main.dart';

class WordsTextbookPage extends StatefulWidget {
  const WordsTextbookPage({super.key});

  @override
  WordsTextbookPageState createState() => WordsTextbookPageState();
}

class WordsTextbookPageState extends State<WordsTextbookPage> {
  final vm = WordsUnitViewModel(false);

  @override
  void initState() {
    super.initState();
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
                            items: SettingsViewModel.scopeWordFilters
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
                itemCount: vm.lstUnitWords.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (BuildContext context, int index) {
                  final entry = vm.lstUnitWords[index];
                  void edit() => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              WordsTextbookDetailPage(vm, entry),
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
                                            child: const Text("Delete"),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            }),
                                        SimpleDialogOption(
                                            child: const Text("Edit"),
                                            onPressed: () {
                                              Navigator.pop(context);
                                              edit();
                                            }),
                                        SimpleDialogOption(
                                            child: const Text("Get Note"),
                                            onPressed: () async {
                                              Navigator.pop(context);
                                              await vm.getNote(entry);
                                            }),
                                        SimpleDialogOption(
                                            child: const Text("Clear Note"),
                                            onPressed: () async {
                                              Navigator.pop(context);
                                              await vm.clearNote(entry);
                                            }),
                                        SimpleDialogOption(
                                            child: const Text("Copy Word"),
                                            onPressed: () {
                                              Navigator.pop(context);
                                              vm.lstUnitWords[index].word
                                                  .copyToClipboard();
                                            }),
                                        SimpleDialogOption(
                                            child: const Text("Google Word"),
                                            onPressed: () {
                                              Navigator.pop(context);
                                              vm.lstUnitWords[index].word
                                                  .google();
                                            }),
                                        SimpleDialogOption(
                                            child:
                                                const Text("Online Dictionary"),
                                            onPressed: () async {
                                              Navigator.pop(context);
                                              final url = vmSettings
                                                  .selectedDictReference!
                                                  .urlString(
                                                      vm.lstUnitWords[index]
                                                          .word,
                                                      vmSettings
                                                          .lstAutoCorrect);
                                              await launchUrl(Uri.parse(url));
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
                            entry.word,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.orange),
                          ),
                          subtitle: Text(entry.note,
                              style: const TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Color.fromARGB(255, 255, 0, 255),
                              )),
                          trailing: IconButton(
                              icon: const Icon(Icons.keyboard_arrow_right,
                                  color: Colors.blue, size: 30.0),
                              onPressed: () => Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    final (start, end) =
                                        getPreferredRangeFromArray(
                                            index, vm.lstUnitWords.length, 50);
                                    return WordsDictPage(
                                        vm.lstUnitWords
                                            .sublist(start, end)
                                            .map((e) => e.word)
                                            .toList(),
                                        index);
                                  }))),
                          onTap: () {
                            speak(entry.word);
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
