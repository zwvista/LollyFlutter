import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lolly_flutter/main.dart';
import 'package:lolly_flutter/models/misc/mcommon.dart';
import 'package:lolly_flutter/viewmodels/misc/search_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'login_page.dart';
import 'online_dict.dart';

class SearchPage extends StatefulWidget {
  final state = SearchPageState();
  @override
  SearchPageState createState() => state;
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
          .push(MaterialPageRoute(builder: (context) => LoginPage()));
    }
    await vmSettings.getData();
    vmSettings.updateLang.listen((v) => onlineDict.searchDict());
    vmSettings.updateDictReference.listen((v) => onlineDict.searchDict());
  }

  SearchPageState() {
    onlineDict = OnlineDict(vm);
    setup();
  }

  Widget build(BuildContext context) => Column(children: [
        TextField(
            autocorrect: false,
            decoration: InputDecoration(
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
                      onChanged: vmSettings.selectedLang_))),
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
                      onChanged: vmSettings.selectedDictReference_))),
        ]),
        Expanded(
          child: WebView(
              initialUrl: vm.getUrl,
              onWebViewCreated: (c) => onlineDict.controller = c,
              onPageFinished: (s) => onlineDict.onPageFinished()),
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
