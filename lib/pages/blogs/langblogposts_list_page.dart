import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../main.dart';
import '../../models/blogs/mlangbloggroup.dart';
import '../../viewmodels/blogs/langbloggroups_viewmodel.dart';
import 'langblogposts_content_page.dart';
import 'langblogposts_detail_page.dart';

class LangBlogPostsListPage extends StatefulWidget {
  const LangBlogPostsListPage(MLangBlogGroup item, {super.key});

  @override
  LangBlogPostsListPageState createState() => LangBlogPostsListPageState();
}

class LangBlogPostsListPageState extends State<LangBlogPostsListPage> {
  final vm = LangBlogGroupsViewModel();

  LangBlogPostsListPageState() {
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
                    decoration: const InputDecoration(
                      hintText: "Filter",
                    ),
                    onChanged: vm.groupFilter_.call,
                  ),
                )
              ])),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: vm.reloadCommand,
              builder: (context, data, _) => ListView.separated(
                itemCount: vm.lstLangBlogPosts.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (BuildContext context, int index) {
                  final entry = vm.lstLangBlogPosts[index];
                  void edit() => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LangBlogPostsDetailPage(entry),
                          fullscreenDialog: true));
                  void browseWebPage() {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return LangBlogPostsContentPage(
                          vm.lstLangBlogPosts, index);
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
                            entry.title,
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
                            speak(entry.title);
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
