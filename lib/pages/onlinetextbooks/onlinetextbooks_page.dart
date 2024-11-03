import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lolly_flutter/pages/onlinetextbooks/onlinetextbooks_detail_page.dart';
import 'package:lolly_flutter/pages/onlinetextbooks/onlinetextbooks_webpage_page.dart';
import 'package:lolly_flutter/viewmodels/onlinetextbooks/onlinetextbooks_viewmodel.dart';
import 'package:rx_widgets/rx_widgets.dart';

import '../../keys.dart';
import '../../main.dart';

class OnlineTextbooksPage extends StatefulWidget {
  const OnlineTextbooksPage({super.key});

  @override
  OnlineTextbooksPageState createState() => OnlineTextbooksPageState();
}

class OnlineTextbooksPageState extends State<OnlineTextbooksPage> {
  final vm = OnlineTextbooksViewModel();

  OnlineTextbooksPageState() {
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
                  child: StreamBuilder(
                      stream: vm.onlineTextbookFilter_,
                      builder: (context, snapshot) => DropdownButtonFormField(
                            value: vm.onlineTextbookFilter,
                            items: vmSettings.lstOnlineTextbookFilters
                                .map((o) => DropdownMenuItem(
                                    value: o.value, child: Text(o.label)))
                                .toList(),
                            onChanged: vm.onlineTextbookFilter_.call,
                          )),
                )
              ])),
          Expanded(
            child: RxLoader(
              spinnerKey: AppKeys.loadingSpinner,
              radius: 25.0,
              commandResults: vm.reloadCommand.results,
              dataBuilder: (context, data) => ListView.separated(
                itemCount: vm.lstOnlineTextbooks.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (BuildContext context, int index) {
                  final entry = vm.lstOnlineTextbooks[index];
                  void edit() => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              OnlineTextbooksDetailPage(entry),
                          fullscreenDialog: true));
                  void browseWebPage() {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return OnlineTextbooksWebPagePage(
                          vm.lstOnlineTextbooks, index);
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
                                      ]),
                                )),
                      ],
                    ),
                    child: Container(
                        color: Colors.white,
                        child: ListTile(
                          title: Text(
                            entry.textbookname,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.orange),
                          ),
                          subtitle: Text(entry.title,
                              style: const TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Color.fromARGB(255, 255, 0, 255),
                              )),
                          trailing: IconButton(
                              icon: const Icon(Icons.keyboard_arrow_right,
                                  color: Colors.blue, size: 30.0),
                              onPressed: () => browseWebPage()),
                          onTap: () {
                            speak(entry.textbookname);
                          },
                        )),
                  );
                },
              ),
              placeHolderBuilder: (context) => const Center(
                  key: AppKeys.loaderPlaceHolder, child: Text("No Data")),
              errorBuilder: (context, ex) => Center(
                  key: AppKeys.loaderError,
                  child: Text("Error: ${ex.toString()}")),
            ),
          ),
        ],
      );
}
