import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lolly_flutter/pages/patterns/patterns_detail_page.dart';
import 'package:lolly_flutter/pages/patterns/patterns_webpage_page.dart';
import 'package:lolly_flutter/services/misc/base_service.dart';
import 'package:lolly_flutter/viewmodels/misc/home_viewmodel.dart';
import 'package:lolly_flutter/viewmodels/misc/settings_viewmodel.dart';
import 'package:lolly_flutter/viewmodels/patterns/patterns_viewmodel.dart';

import '../../main.dart';

class PatternsPage extends StatefulWidget {
  final HomeViewModel vmHome;
  const PatternsPage(this.vmHome, {super.key});

  @override
  PatternsPageState createState() => PatternsPageState();
}

class PatternsPageState extends State<PatternsPage> {
  final vm = PatternsViewModel();

  @override
  void initState() {
    super.initState();
    widget.vmHome.more = more;
    _pullRefresh();
  }

  Future<void> _pullRefresh() async {
    vm.reloaded = false;
    await vm.reloadCommand.executeWithFuture();
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
                          items: SettingsViewModel.scopePatternFilters
                              .map((s) =>
                                  DropdownMenuItem(value: s, child: Text(s)))
                              .toList(),
                          onChanged: vm.scopeFilter_.call,
                        ))
              ])),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _pullRefresh,
              child: ValueListenableBuilder(
                valueListenable: vm.reloadCommand,
                builder: (context, data, _) => ListView.separated(
                  itemCount: vm.lstPatterns.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (BuildContext context, int index) {
                    final entry = vm.lstPatterns[index];
                    void edit() => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PatternsDetailPage(vm, entry),
                            fullscreenDialog: true));
                    void browseWebPage() {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return PatternsWebPagePage(vm.lstPatterns, index);
                      }));
                    }

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
                                              child:
                                                  const Text("Browse Web Page"),
                                              onPressed: () {
                                                Navigator.pop(context);
                                                browseWebPage();
                                              }),
                                          SimpleDialogOption(
                                              child: const Text("Copy Pattern"),
                                              onPressed: () {
                                                Navigator.pop(context);
                                                vm.lstPatterns[index].pattern
                                                    .copyToClipboard();
                                              }),
                                          SimpleDialogOption(
                                              child:
                                                  const Text("Google Pattern"),
                                              onPressed: () {
                                                Navigator.pop(context);
                                                vm.lstPatterns[index].pattern
                                                    .google();
                                              }),
                                        ]),
                                  )),
                        ],
                      ),
                      child: Container(
                          color: Colors.white,
                          child: ListTile(
                            title: Text(
                              entry.pattern,
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.orange),
                            ),
                            subtitle: Text(entry.tags,
                                style: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Color.fromARGB(255, 255, 0, 255),
                                )),
                            trailing: IconButton(
                                icon: const Icon(Icons.keyboard_arrow_right,
                                    color: Colors.blue, size: 30.0),
                                onPressed: () => browseWebPage()),
                            onTap: () {
                              speak(entry.pattern);
                            },
                          )),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      );

  void more() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PatternsDetailPage(vm, vm.newPattern())));
  }
}
