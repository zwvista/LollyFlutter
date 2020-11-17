import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lolly_flutter/models/wpp/munitword.dart';
import 'package:lolly_flutter/pages/words/wordsdictpage.dart';
import 'package:lolly_flutter/viewmodels/settingsviewmodel.dart';
import 'package:lolly_flutter/viewmodels/words/wordsunitviewmodel.dart';
import 'package:rx_widgets/rx_widgets.dart';

import '../../keys.dart';

class WordsTextbookPage extends StatefulWidget {
  @override
  WordsTextbookPageState createState() {
    return WordsTextbookPageState();
  }
}

class WordsTextbookPageState extends State<WordsTextbookPage> {
  final TextEditingController _controller = TextEditingController();
  final vm = WordsUnitViewModel(false);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(children: <Widget>[
              Expanded(
                child: TextField(
                  key: AppKeys.textField,
                  autocorrect: false,
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: "Filter",
                  ),
                  onChanged: vm.textChangedCommand,
                ),
              ),
              DropdownButton(
                value: vm.scopeFilter,
                items: SettingsViewModel.scopeWordFilters
                    .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                    .toList(),
                onChanged: (s) => setState(() => vm.scopeFilter = s),
              )
            ])),
        Expanded(
          child: RxLoader<List<MUnitWord>>(
            spinnerKey: AppKeys.loadingSpinner,
            radius: 25.0,
            commandResults: vm.reloadCommand.results,
            dataBuilder: (context, data) => WordsTextbookListView(data),
            placeHolderBuilder: (context) =>
                Center(key: AppKeys.loaderPlaceHolder, child: Text("No Data")),
            errorBuilder: (context, ex) => Center(
                key: AppKeys.loaderError,
                child: Text("Error: ${ex.toString()}")),
          ),
        ),
      ],
    );
  }
}

class WordsTextbookListView extends StatelessWidget {
  final List<MUnitWord> data;

  WordsTextbookListView(this.data, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: AppKeys.cityList,
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) =>
          WordsTextbookItem(entry: data[index]),
    );
  }
}

class WordsTextbookItem extends StatelessWidget {
  final MUnitWord entry;

  WordsTextbookItem({Key key, @required this.entry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
          color: Colors.white,
          child: ListTile(
              leading: Column(children: <Widget>[
                Text(entry.unitstr, style: TextStyle(color: Colors.blue)),
                Text(entry.partstr, style: TextStyle(color: Colors.blue)),
                Text(entry.seqnum.toString(),
                    style: TextStyle(color: Colors.blue))
              ]),
              title: Text(
                entry.word,
                style: TextStyle(fontSize: 20, color: Colors.orange),
              ),
              subtitle: Text(entry.note,
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Color.fromARGB(255, 255, 0, 255),
                  )),
              trailing: IconButton(
                  icon: Icon(Icons.keyboard_arrow_right,
                      color: Colors.blue, size: 30.0),
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => WordsDictPage()))))),
      actions: <Widget>[
        IconSlideAction(
          caption: 'Archive',
          color: Colors.blue,
          icon: Icons.archive,
        ),
        IconSlideAction(
          caption: 'Share',
          color: Colors.indigo,
          icon: Icons.share,
        ),
      ],
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'More',
          color: Colors.black45,
          icon: Icons.more_horiz,
        ),
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
        ),
      ],
    );
  }
}