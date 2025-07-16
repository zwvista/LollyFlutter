import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../main.dart';
import '../../viewmodels/blogs/langbloggroups_viewmodel.dart';
import 'langbloggroups_detail_page.dart';
import 'langblogposts_list_page.dart';

class LangBlogGroupsPage extends StatefulWidget {
  const LangBlogGroupsPage({super.key});

  @override
  LangBlogGroupsPageState createState() => LangBlogGroupsPageState();
}

class LangBlogGroupsPageState extends State<LangBlogGroupsPage> {
  final vm = LangBlogGroupsViewModel();

  @override
  void initState() {
    super.initState();
    vm.reloadedGroups = false;
    vm.reloadGroupsCommand();
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
                    onChanged: vm.groupFilter_.call,
                  ),
                )
              ])),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: vm.reloadGroupsCommand,
              builder: (context, data, _) => ListView.separated(
                itemCount: vm.lstLangBlogGroups.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (BuildContext context, int index) {
                  final entry = vm.lstLangBlogGroups[index];
                  void edit() => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LangBlogGroupsDetailPage(entry),
                          fullscreenDialog: true));
                  void showPosts() {
                    vm.selectedGroup_(entry);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return LangBlogPostsListPage(vm);
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
                                            child: const Text("Show Posts"),
                                            onPressed: () {
                                              Navigator.pop(context);
                                              showPosts();
                                            }),
                                      ]),
                                )),
                      ],
                    ),
                    child: Container(
                        color: Colors.white,
                        child: ListTile(
                          title: Text(
                            entry.groupname,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.orange),
                          ),
                          subtitle: Text(entry.groupname,
                              style: const TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Color.fromARGB(255, 255, 0, 255),
                              )),
                          trailing: IconButton(
                              icon: const Icon(Icons.keyboard_arrow_right,
                                  color: Colors.blue, size: 30.0),
                              onPressed: () => showPosts()),
                          onTap: () {
                            speak(entry.groupname);
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
