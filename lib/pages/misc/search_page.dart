import 'package:flutter/material.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:lolly_flutter/main.dart';
import 'package:lolly_flutter/models/misc/mcommon.dart';
import 'package:lolly_flutter/viewmodels/misc/search_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../viewmodels/misc/home_viewmodel.dart';
import 'login_page.dart';
import 'online_dict.dart';

class SearchPage extends StatefulWidget {
  final HomeViewModel vmHome;
  const SearchPage(this.vmHome, {super.key});

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  late SearchViewModel vm;
  late OnlineDict onlineDict;

  @override
  void initState() {
    super.initState();
    vm = SearchViewModel();
    onlineDict = OnlineDict(vm);
    widget.vmHome.more = more;
    setup();
  }

  Future<void> setup() async {
    final prefs = await SharedPreferences.getInstance();
    for (;;) {
      Global.userid = prefs.getString("userid") ?? "";
      if (Global.userid.isNotEmpty) break;
      if (mounted) {
        // https://stackoverflow.com/questions/59423954/detect-when-we-moved-back-to-previous-page-in-flutter
        await Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginPage()));
      }
    }
    await vmSettings.getData();
    vmSettings.updateLang.listen((v, _) => onlineDict.searchDict());
    vmSettings.updateDictReference.listen((v, _) => onlineDict.searchDict());
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
              child: ValueListenableBuilder(
                  valueListenable: vmSettings.selectedLang_,
                  builder: (context, value, _) => DropdownButton(
                      value: vmSettings.selectedLang,
                      items: vmSettings.lstLanguages
                          .map((e) => DropdownMenuItem(
                              value: e, child: Text(e.langname)))
                          .toList(),
                      isExpanded: true,
                      onChanged: vmSettings.selectedLang_.call))),
          Expanded(
              child: ValueListenableBuilder(
                  valueListenable: vmSettings.selectedDictReference_,
                  builder: (context, value, _) => DropdownButton(
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

  Future<void> login() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("userid");
    await setup();
  }

  void more() {
    login();
  }
}
