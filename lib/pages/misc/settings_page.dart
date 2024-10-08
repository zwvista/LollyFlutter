import 'package:flutter/material.dart';
import 'package:lolly_flutter/main.dart';
import 'package:lolly_flutter/models/misc/mcommon.dart';
import 'package:lolly_flutter/viewmodels/misc/settings_viewmodel.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  final vm = vmSettings;

  SettingsPageState() {
    vm.getData();
  }

  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: ListView(children: [
        StreamBuilder(
            stream: vm.selectedLang_,
            builder: (context, snapshot) => DropdownButtonFormField(
                  value: vm.selectedLang,
                  items: vm.lstLanguages
                      .map((e) =>
                          DropdownMenuItem(value: e, child: Text(e.langname)))
                      .toList(),
                  onChanged: vm.selectedLang_.call,
                  decoration: const InputDecoration(
                    labelText: "Language",
                  ),
                )),
        StreamBuilder(
            stream: vm.selectedVoice_,
            builder: (context, snapshot) => DropdownButtonFormField(
                  value: vm.selectedVoice,
                  items: vm.lstVoices
                      .map((e) =>
                          DropdownMenuItem(value: e, child: Text(e.voicename)))
                      .toList(),
                  onChanged: vm.selectedVoice_.call,
                  decoration: const InputDecoration(
                    labelText: "Voice",
                  ),
                )),
        StreamBuilder(
            stream: vm.selectedDictReference_,
            builder: (context, snapshot) => DropdownButtonFormField(
                  value: vm.selectedDictReference,
                  items: vm.lstDictsReference
                      .map((e) =>
                          DropdownMenuItem(value: e, child: Text(e.dictname)))
                      .toList(),
                  onChanged: vm.selectedDictReference_.call,
                  decoration: const InputDecoration(
                    labelText: "Dictionary(Reference)",
                  ),
                )),
        StreamBuilder(
            stream: vm.selectedDictNote_,
            builder: (context, snapshot) => DropdownButtonFormField(
                  value: vm.selectedDictNote,
                  items: vm.lstDictsNote
                      .map((e) =>
                          DropdownMenuItem(value: e, child: Text(e.dictname)))
                      .toList(),
                  onChanged: vm.selectedDictNote_.call,
                  decoration: const InputDecoration(
                    labelText: "Dictionary(Note)",
                  ),
                )),
        StreamBuilder(
            stream: vm.selectedDictTranslation_,
            builder: (context, snapshot) => DropdownButtonFormField(
                  value: vm.selectedDictTranslation,
                  items: vm.lstDictsTranslation
                      .map((e) =>
                          DropdownMenuItem(value: e, child: Text(e.dictname)))
                      .toList(),
                  onChanged: vm.selectedDictTranslation_.call,
                  decoration: const InputDecoration(
                    labelText: "Dictionary(Translation)",
                  ),
                )),
        StreamBuilder(
            stream: vm.selectedTextbook_,
            builder: (context, snapshot) => DropdownButtonFormField(
                  value: vm.selectedTextbook,
                  items: vm.lstTextbooks
                      .map((e) => DropdownMenuItem(
                          value: e, child: Text(e.textbookname)))
                      .toList(),
                  onChanged: vm.selectedTextbook_.call,
                  decoration: const InputDecoration(
                    labelText: "Textbook",
                  ),
                )),
        StreamBuilder(
            stream: vm.selectedUnitFrom,
            builder: (context, snapshot) => DropdownButtonFormField(
                  value: vm.usunitfrom,
                  items: vm.lstUnits
                      .map((e) => DropdownMenuItem(
                          value: e.value, child: Text(e.label)))
                      .toList(),
                  onChanged: vm.selectedUnitFrom.call,
                  decoration: const InputDecoration(
                    labelText: "Unit(From)",
                  ),
                )),
        StreamBuilder(
            stream: vm.toType_,
            builder: (context, snapshot) => StreamBuilder(
                stream: vm.selectedPartFrom,
                builder: (context, snapshot) => DropdownButtonFormField(
                      disabledHint: Text(vm.uspartfromstr),
                      value: vm.uspartfrom,
                      items: vm.lstParts
                          .map((e) => DropdownMenuItem(
                              value: e.value, child: Text(e.label)))
                          .toList(),
                      onChanged: !vm.partFromEnabled
                          ? null
                          : (int? v) => vm.selectedPartFrom(v),
                      decoration: const InputDecoration(
                        labelText: "Part(From)",
                      ),
                    ))),
        StreamBuilder(
            stream: vm.toType_,
            builder: (context, snapshot) => Row(
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
                        onChanged: vm.toType_.call,
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: OverflowBar(
                          children: [
                            TextButton(
                                onPressed: !vm.previousEnabled
                                    ? null
                                    : () => vm.previousUnitPart(),
                                child: Text(vm.previousText)),
                            TextButton(
                                onPressed: !vm.nextEnabled
                                    ? null
                                    : () => vm.nextUnitPart(),
                                child: Text(vm.nextText))
                          ],
                        )),
                  ],
                )),
        StreamBuilder(
            stream: vm.toType_,
            builder: (context, snapshot) => StreamBuilder(
                stream: vm.selectedUnitTo,
                builder: (context, snapshot) => DropdownButtonFormField(
                      disabledHint: Text(vm.usunittostr),
                      value: vm.usunitto,
                      items: vm.lstUnits
                          .map((e) => DropdownMenuItem(
                              value: e.value, child: Text(e.label)))
                          .toList(),
                      onChanged: !vm.unitToEnabled
                          ? null
                          : (int? v) => vm.selectedUnitTo(v),
                      decoration: const InputDecoration(
                        labelText: "Unit(To)",
                      ),
                    ))),
        StreamBuilder(
            stream: vm.toType_,
            builder: (context, snapshot) => StreamBuilder(
                stream: vm.selectedPartTo,
                builder: (context, snapshot) => DropdownButtonFormField(
                      disabledHint: Text(vm.usparttostr),
                      value: vm.uspartto,
                      items: vm.lstParts
                          .map((e) => DropdownMenuItem(
                              value: e.value, child: Text(e.label)))
                          .toList(),
                      onChanged: !vm.partToEnabled
                          ? null
                          : (int? v) => vm.selectedPartTo(v),
                      decoration: const InputDecoration(
                        labelText: "Part(To)",
                      ),
                    ))),
      ]));
}
