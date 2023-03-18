import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lolly_flutter/pages/patterns/patterns_detail_page.dart';
import 'package:lolly_flutter/pages/patterns/patterns_webpage_page.dart';
import 'package:lolly_flutter/services/misc/base_service.dart';
import 'package:lolly_flutter/viewmodels/misc/settings_viewmodel.dart';
import 'package:lolly_flutter/viewmodels/patterns/patterns_viewmodel.dart';
import 'package:rx_widgets/rx_widgets.dart';

import '../../keys.dart';
import '../../main.dart';

class PatternsPage extends StatefulWidget {
  final state = PatternsPageState();
  @override
  PatternsPageState createState() => state;
}

class PatternsPageState extends State<PatternsPage> {
  final vm = PatternsViewModel();

  PatternsPageState() {
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
                          items: SettingsViewModel.scopePatternFilters
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
                itemCount: vm.lstPatterns.length,
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (BuildContext context, int index) {
                  final entry = vm.lstPatterns[index];
                  void edit() => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PatternsDetailPage(vm, entry),
                      fullscreenDialog: true));

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
                          trailing: IconButton(
                              icon: Icon(Icons.keyboard_arrow_right,
                                  color: Colors.blue, size: 30.0),
                              onPressed: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => PatternsWebPagePage(
                                          vm.lstPatterns[index])))),
                          onTap: () {
                            speak(entry.pattern);
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
                                          child: Text("Browse Web Page"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        PatternsWebPagePage(
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
        builder: (context) => PatternsDetailPage(vm, vm.newPattern())));
  }
}
