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

  @override
  void initState() {
    super.initState();
    _pullRefresh();
  }

  Future<void> _pullRefresh() async {
    await vm.getData();
    ;
  }

  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: RefreshIndicator(
          onRefresh: _pullRefresh,
          child: ListView(children: [
            ValueListenableBuilder(
                valueListenable: vm.selectedLang_,
                builder: (context, value, _) => DropdownButtonFormField(
                      value: vm.selectedLang,
                      items: vm.lstLanguages
                          .map((e) => DropdownMenuItem(
                              value: e, child: Text(e.langname)))
                          .toList(),
                      onChanged: vm.selectedLang_.call,
                      decoration: const InputDecoration(
                        labelText: "Language",
                      ),
                    )),
            ValueListenableBuilder(
                valueListenable: vm.selectedVoice_,
                builder: (context, value, _) => DropdownButtonFormField(
                      value: vm.selectedVoice,
                      items: vm.lstVoices
                          .map((e) => DropdownMenuItem(
                              value: e, child: Text(e.voicename)))
                          .toList(),
                      onChanged: vm.selectedVoice_.call,
                      decoration: const InputDecoration(
                        labelText: "Voice",
                      ),
                    )),
            ValueListenableBuilder(
                valueListenable: vm.selectedDictReference_,
                builder: (context, value, _) => DropdownButtonFormField(
                      value: vm.selectedDictReference,
                      items: vm.lstDictsReference
                          .map((e) => DropdownMenuItem(
                              value: e, child: Text(e.dictname)))
                          .toList(),
                      onChanged: vm.selectedDictReference_.call,
                      decoration: const InputDecoration(
                        labelText: "Dictionary(Reference)",
                      ),
                    )),
            ValueListenableBuilder(
                valueListenable: vm.selectedDictNote_,
                builder: (context, value, _) => DropdownButtonFormField(
                      value: vm.selectedDictNote,
                      items: vm.lstDictsNote
                          .map((e) => DropdownMenuItem(
                              value: e, child: Text(e.dictname)))
                          .toList(),
                      onChanged: vm.selectedDictNote_.call,
                      decoration: const InputDecoration(
                        labelText: "Dictionary(Note)",
                      ),
                    )),
            ValueListenableBuilder(
                valueListenable: vm.selectedDictTranslation_,
                builder: (context, value, _) => DropdownButtonFormField(
                      value: vm.selectedDictTranslation,
                      items: vm.lstDictsTranslation
                          .map((e) => DropdownMenuItem(
                              value: e, child: Text(e.dictname)))
                          .toList(),
                      onChanged: vm.selectedDictTranslation_.call,
                      decoration: const InputDecoration(
                        labelText: "Dictionary(Translation)",
                      ),
                    )),
            ValueListenableBuilder(
                valueListenable: vm.selectedTextbook_,
                builder: (context, value, _) => DropdownButtonFormField(
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
            ValueListenableBuilder(
                valueListenable: vm.selectedUnitFrom,
                builder: (context, value, _) => DropdownButtonFormField(
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
            ValueListenableBuilder(
                valueListenable: vm.toType_,
                builder: (context, value, _) => ValueListenableBuilder(
                    valueListenable: vm.selectedPartFrom,
                    builder: (context, value, _) => DropdownButtonFormField(
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
            ValueListenableBuilder(
                valueListenable: vm.toType_,
                builder: (context, value, _) => Row(
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
            ValueListenableBuilder(
                valueListenable: vm.toType_,
                builder: (context, value, _) => ValueListenableBuilder(
                    valueListenable: vm.selectedUnitTo,
                    builder: (context, value, _) => DropdownButtonFormField(
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
            ValueListenableBuilder(
                valueListenable: vm.toType_,
                builder: (context, value, _) => ValueListenableBuilder(
                    valueListenable: vm.selectedPartTo,
                    builder: (context, value, _) => DropdownButtonFormField(
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
          ])));
}
