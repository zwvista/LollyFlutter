import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lolly_flutter/bloc/nav_drawer_bloc.dart';
import 'package:lolly_flutter/bloc/nav_drawer_state.dart';
import 'package:lolly_flutter/drawer_widget.dart';
import 'package:lolly_flutter/pages/misc/settingspage.dart';
import 'package:lolly_flutter/pages/phrases/phraseslangpage.dart';
import 'package:lolly_flutter/pages/phrases/phrasestextbookpage.dart';
import 'package:lolly_flutter/pages/phrases/phrasesunitpage.dart';
import 'package:lolly_flutter/pages/words/wordslangpage.dart';
import 'package:lolly_flutter/pages/words/wordstextbookpage.dart';
import 'package:lolly_flutter/pages/words/wordsunitpage.dart';
import 'package:lolly_flutter/viewmodels/misc/settingsviewmodel.dart';

var vmSettings = SettingsViewModel();

void main() async {
  await vmSettings.getData();
  runApp(MyApp());
}

// https://github.com/askNilesh/flutter_drawer_with_bloc
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lolly Flutter',
      theme: ThemeData(
          primarySwatch: Colors.blue, scaffoldBackgroundColor: Colors.white),
      home: MyHomePage(),
    );
    ;
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  NavDrawerBloc _bloc;
  Widget _content;

  @override
  void initState() {
    super.initState();
    _bloc = NavDrawerBloc();
    _content = _getContentForState(_bloc.state.selectedItem);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider<NavDrawerBloc>(
      create: (BuildContext context) => _bloc,
      child: BlocListener<NavDrawerBloc, NavDrawerState>(
        listener: (BuildContext context, NavDrawerState state) {
          setState(() {
            _content = _getContentForState(state.selectedItem);
          });
        },
        child: BlocBuilder<NavDrawerBloc, NavDrawerState>(
          builder: (BuildContext context, NavDrawerState state) => Scaffold(
            drawer: NavDrawerWidget("Lolly", "xxx@xxx.com"),
            appBar: AppBar(
              title: Text(_getAppbarTitle(state.selectedItem)),
              centerTitle: false,
              brightness: Brightness.light,
              backgroundColor: Colors.indigo,
            ),
            body: AnimatedSwitcher(
              switchInCurve: Curves.easeInExpo,
              switchOutCurve: Curves.easeOutExpo,
              duration: Duration(milliseconds: 300),
              child: _content,
            ),
          ),
        ),
      ));

  _getAppbarTitle(NavItem state) {
    switch (state) {
      case NavItem.homePage:
        return 'Home';
      case NavItem.settingsPage:
        return 'Settings';
      case NavItem.wordsUnitPage:
        return 'Words in Unit';
      case NavItem.phrasesUnitPage:
        return 'Phrases in Unit';
      case NavItem.wordsTextbookPage:
        return 'Words in Textbook';
      case NavItem.phrasesTextbookPage:
        return 'Phrases in Textbook';
      case NavItem.wordsLangPage:
        return 'Words in Language';
      case NavItem.phrasesLangPage:
        return 'Phrases in Language';
      case NavItem.myCart:
        return 'My Cart';
      default:
        return '';
    }
  }

  _getContentForState(NavItem state) {
    switch (state) {
      case NavItem.homePage:
        return Center(
          child: Text(
            'Home Page',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        );
      case NavItem.settingsPage:
        return SettingsPage();
      case NavItem.wordsUnitPage:
        return WordsUnitPage();
      case NavItem.phrasesUnitPage:
        return PhrasesUnitPage();
      case NavItem.wordsTextbookPage:
        return WordsTextbookPage();
      case NavItem.phrasesTextbookPage:
        return PhrasesTextbookPage();
      case NavItem.wordsLangPage:
        return WordsLangPage();
      case NavItem.phrasesLangPage:
        return PhrasesLangPage();
      case NavItem.myCart:
        return Center(
          child: Text(
            'My Cart',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        );
      default:
        return Center(
          child: Text(
            'Home Page',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        );
    }
  }
}
