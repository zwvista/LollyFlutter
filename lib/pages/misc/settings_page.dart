import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lolly_flutter/models/misc/mcommon.dart';
import 'package:lolly_flutter/viewmodels/misc/settings_viewmodel.dart';

class SettingsPage extends StatefulWidget {
  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  final vm = SettingsViewModel();

  SettingsPageState() {
    vm.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: ListView(children: [
          StreamBuilder(
              stream: vm.selectedLang_,
              builder: (context, snapshot) => DropdownButtonFormField(
                    value: vm.selectedLang,
                    items: vm.lstLanguages
                        ?.map((e) =>
                            DropdownMenuItem(value: e, child: Text(e.langname)))
                        ?.toList(),
                    onChanged: vm.selectedLang_,
                    decoration: InputDecoration(
                      labelText: "Language",
                    ),
                  )),
          StreamBuilder(
              stream: vm.selectedVoice_,
              builder: (context, snapshot) => DropdownButtonFormField(
                    value: vm.selectedVoice,
                    items: vm.lstVoices
                        ?.map((e) => DropdownMenuItem(
                            value: e, child: Text(e.voicename)))
                        ?.toList(),
                    onChanged: vm.selectedVoice_,
                    decoration: InputDecoration(
                      labelText: "Voice",
                    ),
                  )),
          StreamBuilder(
              stream: vm.selectedDictReference_,
              builder: (context, snapshot) => DropdownButtonFormField(
                    value: vm.selectedDictReference,
                    items: vm.lstDictsReference
                        ?.map((e) =>
                            DropdownMenuItem(value: e, child: Text(e.dictname)))
                        ?.toList(),
                    onChanged: vm.selectedDictReference_,
                    decoration: InputDecoration(
                      labelText: "Dictionary(Reference)",
                    ),
                  )),
          StreamBuilder(
              stream: vm.selectedDictNote_,
              builder: (context, snapshot) => DropdownButtonFormField(
                    value: vm.selectedDictNote,
                    items: vm.lstDictsNote
                        ?.map((e) =>
                            DropdownMenuItem(value: e, child: Text(e.dictname)))
                        ?.toList(),
                    onChanged: vm.selectedDictNote_,
                    decoration: InputDecoration(
                      labelText: "Dictionary(Note)",
                    ),
                  )),
          StreamBuilder(
              stream: vm.selectedDictTranslation_,
              builder: (context, snapshot) => DropdownButtonFormField(
                    value: vm.selectedDictTranslation,
                    items: vm.lstDictsTranslation
                        ?.map((e) =>
                            DropdownMenuItem(value: e, child: Text(e.dictname)))
                        ?.toList(),
                    onChanged: vm.selectedDictTranslation_,
                    decoration: InputDecoration(
                      labelText: "Dictionary(Translation)",
                    ),
                  )),
          StreamBuilder(
              stream: vm.selectedTextbook_,
              builder: (context, snapshot) => DropdownButtonFormField(
                    value: vm.selectedTextbook,
                    items: vm.lstTextbooks
                        ?.map((e) => DropdownMenuItem(
                            value: e, child: Text(e.textbookname)))
                        ?.toList(),
                    onChanged: vm.selectedTextbook_,
                    decoration: InputDecoration(
                      labelText: "Textbook",
                    ),
                  )),
          DropdownButtonFormField(
            value: vm.usunitfrom,
            items: vm.lstUnits
                ?.map((e) =>
                    DropdownMenuItem(value: e.value, child: Text(e.label)))
                ?.toList(),
            onChanged: (e) => vm.updateUnitFrom(e),
            decoration: InputDecoration(
              labelText: "Unit(From)",
            ),
          ),
          DropdownButtonFormField(
            disabledHint: Text(vm.uspartfromstr),
            value: vm.uspartfrom,
            items: vm.lstParts
                ?.map((e) =>
                    DropdownMenuItem(value: e.value, child: Text(e.label)))
                ?.toList(),
            onChanged:
                !vm.partFromIsEnabled ? null : (e) => vm.updatePartFrom(e),
            decoration: InputDecoration(
              labelText: "Part(From)",
            ),
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: DropdownButtonFormField(
                  value: vm.toType,
                  items: SettingsViewModel.lstToTypes
                      .map((e) => DropdownMenuItem(
                          value: UnitPartToType.values[e.value],
                          child: Text(e.label)))
                      .toList(),
                  onChanged: (e) => vm.setToType(e),
                ),
              ),
              Expanded(
                  flex: 2,
                  child: ButtonBar(
                    children: [
                      TextButton(
                          onPressed: !vm.previousIsEnabled
                              ? null
                              : () => vm.previousUnitPart(),
                          child: Text(vm.previousText)),
                      TextButton(
                          onPressed: !vm.nextIsEnabled
                              ? null
                              : () => vm.nextUnitPart(),
                          child: Text(vm.nextText))
                    ],
                  )),
            ],
          ),
          DropdownButtonFormField(
            disabledHint: Text(vm.usunittostr),
            value: vm.usunitto,
            items: vm.lstUnits
                ?.map((e) =>
                    DropdownMenuItem(value: e.value, child: Text(e.label)))
                ?.toList(),
            onChanged: !vm.unitToIsEnabled ? null : (e) => vm.updateUnitTo(e),
            decoration: InputDecoration(
              labelText: "Unit(To)",
            ),
          ),
          DropdownButtonFormField(
            disabledHint: Text(vm.usparttostr),
            value: vm.uspartto,
            items: vm.lstParts
                ?.map((e) =>
                    DropdownMenuItem(value: e.value, child: Text(e.label)))
                ?.toList(),
            onChanged: !vm.partToIsEnabled ? null : (e) => vm.updatePartTo(e),
            decoration: InputDecoration(
              labelText: "Part(To)",
            ),
          ),
        ]));
  }
}
