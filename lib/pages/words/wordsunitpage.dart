import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lolly_flutter/models/wpp/munitword.dart';
import 'package:lolly_flutter/pages/words/wordsdictpage.dart';
import 'package:lolly_flutter/viewmodels/words/wordsunitviewmodel.dart';
import 'package:rx_widgets/rx_widgets.dart';

import '../../keys.dart';

class WordsUnitPage extends StatefulWidget {
  @override
  WordsUnitPageState createState() {
    return WordsUnitPageState();
  }
}

class WordsUnitPageState extends State<WordsUnitPage> {
  final TextEditingController _controller = TextEditingController();
  final vm = WordsUnitViewModel(true);

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
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                  onChanged: vm.textChangedCommand,
                ),
              )
            ])),
        Expanded(
          child: RxLoader<List<MUnitWord>>(
            spinnerKey: AppKeys.loadingSpinner,
            radius: 25.0,
            commandResults: vm.reloadCommand.results,
            dataBuilder: (context, data) =>
                WordsUnitListView(data, key: AppKeys.wordsUnitList),
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

class WordsUnitListView extends StatelessWidget {
  final List<MUnitWord> data;

  WordsUnitListView(this.data, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: AppKeys.cityList,
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) =>
          WordsUnitItem(entry: data[index]),
    );
  }
}

class WordsUnitItem extends StatelessWidget {
  final MUnitWord entry;

  WordsUnitItem({Key key, @required this.entry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Column(children: <Widget>[
          Text(entry.unitstr, style: TextStyle(color: Colors.blue)),
          Text(entry.partstr, style: TextStyle(color: Colors.blue)),
          Text(entry.seqnum.toString(), style: TextStyle(color: Colors.blue))
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
        trailing:
            Icon(Icons.keyboard_arrow_right, color: Colors.blue, size: 30.0),
        onTap: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => WordsDictPage())));
  }
}
