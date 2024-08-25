import 'package:flutter/material.dart';
import 'package:lolly_flutter/main.dart';
import 'package:lolly_flutter/models/misc/mcommon.dart';
import 'package:lolly_flutter/viewmodels/misc/search_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'login_page.dart';
import 'online_dict.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  final vm = SearchViewModel();
  late OnlineDict onlineDict;

  Future setup() async {
    final prefs = await SharedPreferences.getInstance();
    for (;;) {
      Global.userid = prefs.getString("userid") ?? "";
      if (Global.userid.isNotEmpty) break;
      // https://stackoverflow.com/questions/59423954/detect-when-we-moved-back-to-previous-page-in-flutter
      await Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const LoginPage()));
    }
    await vmSettings.getData();
    vmSettings.updateLang.listen((_) => onlineDict.searchDict());
    vmSettings.updateDictReference.listen((_) => onlineDict.searchDict());
  }

  SearchPageState() {
    onlineDict = OnlineDict(vm, 'https://google.com');
    setup();
  }

  @override
  Widget build(BuildContext context) => Column(children: [
        TextField(
            autocorrect: false,
            decoration: const InputDecoration(
              hintText: "Enter a word here",
            ),
            onChanged: (s) {
              setState(() {
                vm.word = s;
                onlineDict.searchDict();
              });
            }),
        Row(children: [
          Expanded(
              child: StreamBuilder(
                  stream: vmSettings.selectedLang_,
                  builder: (context, snapshot) => DropdownButton(
                      value: vmSettings.selectedLang,
                      items: vmSettings.lstLanguages
                          .map((e) => DropdownMenuItem(
                              value: e, child: Text(e.langname)))
                          .toList(),
                      isExpanded: true,
                      onChanged: vmSettings.selectedLang_.call))),
          Expanded(
              child: StreamBuilder(
                  stream: vmSettings.selectedDictReference_,
                  builder: (context, snapshot) => DropdownButton(
                      value: vmSettings.selectedDictReference,
                      items: vmSettings.lstDictsReference
                          .map((e) => DropdownMenuItem(
                              value: e, child: Text(e.dictname)))
                          .toList(),
                      isExpanded: true,
                      onChanged: vmSettings.selectedDictReference_.call))),
        ]),
        Expanded(
          child: WebViewWidget(controller: onlineDict.controller),
        )
      ]);

  Future login() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("userid");
    await setup();
  }

  void more() {
    login();
  }
}
