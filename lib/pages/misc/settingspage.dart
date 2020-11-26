import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lolly_flutter/models/misc/mcommon.dart';
import 'package:lolly_flutter/viewmodels/misc/settingsviewmodel.dart';

class SettingsPage extends StatefulWidget {
  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  final vm = SettingsViewModel();

  SettingsPageState() {
    init();
  }

  void init() async {
    await vm.getData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Column(children: [
              DropdownButtonFormField(
                value: vm.selectedLang,
                items: vm.lstLanguages
                    ?.map((e) =>
                        DropdownMenuItem(value: e, child: Text(e.langname)))
                    ?.toList(),
                onChanged: (e) => setState(() => vm.setSelectedLang(e)),
                decoration: InputDecoration(
                  labelText: "Language",
                ),
              ),
              DropdownButtonFormField(
                value: vm.selectedVoice,
                items: vm.lstVoices
                    ?.map((e) =>
                        DropdownMenuItem(value: e, child: Text(e.voicename)))
                    ?.toList(),
                onChanged: (e) => setState(() => vm.setSelectedVoice(e)),
                decoration: InputDecoration(
                  labelText: "Voice",
                ),
              ),
              DropdownButtonFormField(
                value: vm.selectedDictReference,
                items: vm.lstDictsReference
                    ?.map((e) =>
                        DropdownMenuItem(value: e, child: Text(e.dictname)))
                    ?.toList(),
                onChanged: (e) =>
                    setState(() => vm.setSelectedDictReference(e)),
                decoration: InputDecoration(
                  labelText: "Dictionary(Reference)",
                ),
              ),
              DropdownButtonFormField(
                value: vm.selectedDictNote,
                items: vm.lstDictsNote
                    ?.map((e) =>
                        DropdownMenuItem(value: e, child: Text(e.dictname)))
                    ?.toList(),
                onChanged: (e) => setState(() => vm.setSelectedDictNote(e)),
                decoration: InputDecoration(
                  labelText: "Dictionary(Note)",
                ),
              ),
              DropdownButtonFormField(
                value: vm.selectedDictTranslation,
                items: vm.lstDictsTranslation
                    ?.map((e) =>
                        DropdownMenuItem(value: e, child: Text(e.dictname)))
                    ?.toList(),
                onChanged: (e) =>
                    setState(() => vm.setSelectedDictTranslation(e)),
                decoration: InputDecoration(
                  labelText: "Dictionary(Translation)",
                ),
              ),
              DropdownButtonFormField(
                value: vm.selectedTextbook,
                items: vm.lstTextbooks
                    ?.map((e) =>
                        DropdownMenuItem(value: e, child: Text(e.textbookname)))
                    ?.toList(),
                onChanged: (e) => setState(() => vm.setSelectedTextbook(e)),
                decoration: InputDecoration(
                  labelText: "Textbook",
                ),
              ),
              DropdownButtonFormField(
                value: vm.usunitfrom,
                items: vm.lstUnits
                    ?.map((e) =>
                        DropdownMenuItem(value: e.value, child: Text(e.label)))
                    ?.toList(),
                onChanged: (e) => setState(() => vm.setSelectedTextbook(e)),
                decoration: InputDecoration(
                  labelText: "Unit(From)",
                ),
              ),
              DropdownButtonFormField(
                value: vm.uspartfrom,
                items: vm.lstParts
                    ?.map((e) =>
                        DropdownMenuItem(value: e.value, child: Text(e.label)))
                    ?.toList(),
                onChanged: (e) => setState(() => vm.setSelectedTextbook(e)),
                decoration: InputDecoration(
                  labelText: "Part(From)",
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField(
                      value: vm.toType,
                      items: SettingsViewModel.lstToTypes
                          .map((e) => DropdownMenuItem(
                              value: UnitPartToType.values[e.value],
                              child: Text(e.label)))
                          .toList(),
                      onChanged: (e) =>
                          setState(() => vm.setSelectedTextbook(e)),
                    ),
                  ),
                  Expanded(
                      child: ButtonBar(
                    children: [
                      FlatButton(onPressed: () {}, child: Text("Previous")),
                      FlatButton(onPressed: () {}, child: Text("Next"))
                    ],
                  )),
                ],
              ),
              DropdownButtonFormField(
                value: vm.usunitto,
                items: vm.lstUnits
                    ?.map((e) =>
                        DropdownMenuItem(value: e.value, child: Text(e.label)))
                    ?.toList(),
                onChanged: (e) => setState(() => vm.setSelectedTextbook(e)),
                decoration: InputDecoration(
                  labelText: "Unit(To)",
                ),
              ),
              DropdownButtonFormField(
                value: vm.uspartto,
                items: vm.lstParts
                    ?.map((e) =>
                        DropdownMenuItem(value: e.value, child: Text(e.label)))
                    ?.toList(),
                onChanged: (e) => setState(() => vm.setSelectedTextbook(e)),
                decoration: InputDecoration(
                  labelText: "Part(To)",
                ),
              ),
            ])));
  }
}
