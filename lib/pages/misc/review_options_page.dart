import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lolly_flutter/models/misc/mreviewoptions.dart';
import 'package:lolly_flutter/packages/checkbox_formfield-0.1.0+3/checkbox_list_tile_formfield.dart';
import 'package:lolly_flutter/viewmodels/misc/settings_viewmodel.dart';

class ReviewOptionsPage extends StatefulWidget {
  final MReviewOptions options;

  const ReviewOptionsPage(this.options, {super.key});

  @override
  ReviewOptionsPageState createState() => ReviewOptionsPageState();
}

class ReviewOptionsPageState extends State<ReviewOptionsPage> {
  final _formKey = GlobalKey<FormState>();
  MReviewOptions get options => widget.options;

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Review Options'), actions: [
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.white,
          ),
          onPressed: () async {
            if (!_formKey.currentState!.validate()) return;
            _formKey.currentState!.save();
            Navigator.pop(context, true);
          },
          child: const Text("Save"),
        )
      ]),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
              key: _formKey,
              child: ListView(children: [
                DropdownButtonFormField(
                    value: options.mode,
                    items: SettingsViewModel.reviewModes
                        .map((o) => DropdownMenuItem(
                            value: ReviewMode.values[o.value],
                            child: Text(o.label)))
                        .toList(),
                    decoration: const InputDecoration(
                      labelText: "Mode",
                    ),
                    onChanged: (v) => v,
                    onSaved: (v) => options.mode = v as ReviewMode),
                CheckboxListTileFormField(
                  initialValue: options.shuffled,
                  title: const Text('Order(Shuffled)'),
                  onSaved: (v) => options.shuffled = v!,
                ),
                CheckboxListTileFormField(
                  initialValue: options.speakingEnabled,
                  title: const Text('Speak(Enabled)'),
                  onSaved: (v) => options.speakingEnabled = v!,
                ),
                CheckboxListTileFormField(
                  initialValue: options.onRepeat,
                  title: const Text('On Repeat'),
                  onSaved: (v) => options.onRepeat = v!,
                ),
                CheckboxListTileFormField(
                  initialValue: options.moveForward,
                  title: const Text('Forward'),
                  onSaved: (v) => options.moveForward = v!,
                ),
                TextFormField(
                    initialValue: options.interval.toString(),
                    decoration: const InputDecoration(
                      labelText: "Interval",
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (v) =>
                        v!.isEmpty ? "Interval must not be empty" : null,
                    onSaved: (s) => options.groupSelected = int.parse(s!)),
                TextFormField(
                    initialValue: options.groupSelected.toString(),
                    decoration: const InputDecoration(
                      labelText: "Group",
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (v) =>
                        v!.isEmpty ? "Group must not be empty" : null,
                    onSaved: (s) => options.groupSelected = int.parse(s!)),
                TextFormField(
                    initialValue: options.groupCount.toString(),
                    decoration: const InputDecoration(
                      labelText: "Groups",
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (v) =>
                        v!.isEmpty ? "Groups must not be empty" : null,
                    onSaved: (s) => options.groupCount = int.parse(s!)),
                TextFormField(
                    initialValue: options.reviewCount.toString(),
                    decoration: const InputDecoration(
                      labelText: "Review",
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (v) =>
                        v!.isEmpty ? "Review must not be empty" : null,
                    onSaved: (s) => options.reviewCount = int.parse(s!)),
              ]))));
}
