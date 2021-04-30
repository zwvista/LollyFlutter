import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:lolly_flutter/bloc/nav_drawer_bloc.dart';
import 'package:lolly_flutter/bloc/nav_drawer_state.dart';
import 'package:lolly_flutter/drawer_widget.dart';
import 'package:lolly_flutter/pages/misc/search_page.dart';
import 'package:lolly_flutter/pages/misc/settings_page.dart';
import 'package:lolly_flutter/pages/patterns/patterns_page.dart';
import 'package:lolly_flutter/pages/phrases/phrases_lang_page.dart';
import 'package:lolly_flutter/pages/phrases/phrases_review_page.dart';
import 'package:lolly_flutter/pages/phrases/phrases_textbook_page.dart';
import 'package:lolly_flutter/pages/phrases/phrases_unit_page.dart';
import 'package:lolly_flutter/pages/words/words_lang_page.dart';
import 'package:lolly_flutter/pages/words/words_review_page.dart';
import 'package:lolly_flutter/pages/words/words_textbook_page.dart';
import 'package:lolly_flutter/pages/words/words_unit_page.dart';
import 'package:lolly_flutter/viewmodels/misc/settings_viewmodel.dart';

final vmSettings = SettingsViewModel();
final flutterTts = FlutterTts();

void main() {
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
    _bloc = NavDrawerBloc(NavDrawerState(NavItem.searchPage));
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
              actions: _getActionsForState(state.selectedItem),
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
      case NavItem.searchPage:
        return 'Search';
      case NavItem.settingsPage:
        return 'Settings';
      case NavItem.wordsUnitPage:
        return 'Words in Unit';
      case NavItem.phrasesUnitPage:
        return 'Phrases in Unit';
      case NavItem.wordsReviewPage:
        return 'Words Review';
      case NavItem.phrasesReviewPage:
        return 'Phrases Review';
      case NavItem.wordsTextbookPage:
        return 'Words in Textbook';
      case NavItem.phrasesTextbookPage:
        return 'Phrases in Textbook';
      case NavItem.wordsLangPage:
        return 'Words in Language';
      case NavItem.phrasesLangPage:
        return 'Phrases in Language';
      case NavItem.patternPage:
        return 'Patterns in Language';
      default:
        return '';
    }
  }

  _getContentForState(NavItem state) {
    switch (state) {
      case NavItem.searchPage:
        return SearchPage();
      case NavItem.settingsPage:
        return SettingsPage();
      case NavItem.wordsUnitPage:
        return WordsUnitPage();
      case NavItem.phrasesUnitPage:
        return PhrasesUnitPage();
      case NavItem.wordsReviewPage:
        return WordsReviewPage();
      case NavItem.phrasesReviewPage:
        return PhrasesReviewPage();
      case NavItem.wordsTextbookPage:
        return WordsTextbookPage();
      case NavItem.phrasesTextbookPage:
        return PhrasesTextbookPage();
      case NavItem.wordsLangPage:
        return WordsLangPage();
      case NavItem.phrasesLangPage:
        return PhrasesLangPage();
      case NavItem.patternPage:
        return PatternsPage();
      default:
        return Center(
          child: Text(
            'Home Page',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        );
    }
  }

  List<IconButton> _getActionsForState(NavItem state) {
    switch (state) {
      case NavItem.searchPage:
        return [
          IconButton(
            icon: Icon(Icons.arrow_circle_down),
            onPressed: () => (_content as SearchPage).state.more(),
          )
        ];
      case NavItem.wordsUnitPage:
        return [
          IconButton(
            icon: Icon(Icons.arrow_circle_down),
            onPressed: () => (_content as WordsUnitPage).state.more(),
          )
        ];
      case NavItem.phrasesUnitPage:
        return [
          IconButton(
            icon: Icon(Icons.arrow_circle_down),
            onPressed: () => (_content as PhrasesUnitPage).state.more(),
          )
        ];
      case NavItem.wordsReviewPage:
        return [
          IconButton(
            icon: Icon(Icons.arrow_circle_down),
            onPressed: () => (_content as WordsReviewPage).state.more(),
          )
        ];
      case NavItem.phrasesReviewPage:
        return [
          IconButton(
            icon: Icon(Icons.arrow_circle_down),
            onPressed: () => (_content as PhrasesReviewPage).state.more(),
          )
        ];
      case NavItem.wordsTextbookPage:
        return [];
      case NavItem.phrasesTextbookPage:
        return [];
      case NavItem.wordsLangPage:
        return [
          IconButton(
            icon: Icon(Icons.arrow_circle_down),
            onPressed: () => (_content as WordsLangPage).state.more(),
          )
        ];
      case NavItem.phrasesLangPage:
        return [
          IconButton(
            icon: Icon(Icons.arrow_circle_down),
            onPressed: () => (_content as PhrasesLangPage).state.more(),
          )
        ];
      case NavItem.patternPage:
        return [
          IconButton(
            icon: Icon(Icons.arrow_circle_down),
            onPressed: () => (_content as PatternsPage).state.more(),
          )
        ];
      default:
        return [];
    }
  }
}

void speak(String text) => flutterTts.speak(text);
