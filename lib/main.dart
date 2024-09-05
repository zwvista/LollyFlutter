import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:lolly_flutter/bloc/nav_drawer_bloc.dart';
import 'package:lolly_flutter/bloc/nav_drawer_state.dart';
import 'package:lolly_flutter/drawer_widget.dart';
import 'package:lolly_flutter/pages/misc/search_page.dart';
import 'package:lolly_flutter/pages/misc/settings_page.dart';
import 'package:lolly_flutter/pages/onlinetextbooks/onlinetextbooks_page.dart';
import 'package:lolly_flutter/pages/patterns/patterns_page.dart';
import 'package:lolly_flutter/pages/phrases/phrases_lang_page.dart';
import 'package:lolly_flutter/pages/phrases/phrases_review_page.dart';
import 'package:lolly_flutter/pages/phrases/phrases_textbook_page.dart';
import 'package:lolly_flutter/pages/phrases/phrases_unit_page.dart';
import 'package:lolly_flutter/pages/words/words_lang_page.dart';
import 'package:lolly_flutter/pages/words/words_review_page.dart';
import 'package:lolly_flutter/pages/words/words_textbook_page.dart';
import 'package:lolly_flutter/pages/words/words_unit_page.dart';
import 'package:lolly_flutter/viewmodels/misc/home_viewmodel.dart';
import 'package:lolly_flutter/viewmodels/misc/settings_viewmodel.dart';

final vmSettings = SettingsViewModel();
final flutterTts = FlutterTts();

void main() {
  runApp(const MyApp());
}

// https://github.com/askNilesh/flutter_drawer_with_bloc
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lolly Flutter',
      theme: ThemeData(
          primarySwatch: Colors.blue, scaffoldBackgroundColor: Colors.white),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  late NavDrawerBloc _bloc;
  late Widget _content;
  HomeViewModel vm = HomeViewModel();

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
              backgroundColor: Colors.purple,
              foregroundColor: Colors.white,
              actions: _getActionsForState(state.selectedItem),
            ),
            body: AnimatedSwitcher(
              switchInCurve: Curves.easeInExpo,
              switchOutCurve: Curves.easeOutExpo,
              duration: const Duration(milliseconds: 300),
              child: _content,
            ),
          ),
        ),
      ));

  _getAppbarTitle(NavItem? state) {
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
      case NavItem.patternsPage:
        return 'Patterns in Language';
      case NavItem.onlineTextbooksPage:
        return 'Online Textbook';
      default:
        return '';
    }
  }

  _getContentForState(NavItem? state) {
    switch (state) {
      case NavItem.searchPage:
        return SearchPage(vm);
      case NavItem.settingsPage:
        return const SettingsPage();
      case NavItem.wordsUnitPage:
        return WordsUnitPage(vm);
      case NavItem.phrasesUnitPage:
        return PhrasesUnitPage(vm);
      case NavItem.wordsReviewPage:
        return WordsReviewPage(vm);
      case NavItem.phrasesReviewPage:
        return PhrasesReviewPage(vm);
      case NavItem.wordsTextbookPage:
        return const WordsTextbookPage();
      case NavItem.phrasesTextbookPage:
        return const PhrasesTextbookPage();
      case NavItem.wordsLangPage:
        return WordsLangPage(vm);
      case NavItem.phrasesLangPage:
        return PhrasesLangPage(vm);
      case NavItem.patternsPage:
        return PatternsPage(vm);
      case NavItem.onlineTextbooksPage:
        return const OnlineTextbooksPage();
      default:
        return const Center(
          child: Text(
            'Home Page',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        );
    }
  }

  List<IconButton> _getActionsForState(NavItem? state) {
    switch (state) {
      case NavItem.searchPage:
        return [
          IconButton(
            icon: const Icon(Icons.arrow_circle_down),
            onPressed: () => vm.more!(),
          )
        ];
      case NavItem.wordsUnitPage:
        return [
          IconButton(
            icon: const Icon(Icons.arrow_circle_down),
            onPressed: () => vm.more!(),
          )
        ];
      case NavItem.phrasesUnitPage:
        return [
          IconButton(
            icon: const Icon(Icons.arrow_circle_down),
            onPressed: () => vm.more!(),
          )
        ];
      case NavItem.wordsReviewPage:
        return [
          IconButton(
            icon: const Icon(Icons.arrow_circle_down),
            onPressed: () => vm.more!(),
          )
        ];
      case NavItem.phrasesReviewPage:
        return [
          IconButton(
            icon: const Icon(Icons.arrow_circle_down),
            onPressed: () => vm.more!(),
          )
        ];
      case NavItem.wordsLangPage:
        return [
          IconButton(
            icon: const Icon(Icons.arrow_circle_down),
            onPressed: () => vm.more!(),
          )
        ];
      case NavItem.phrasesLangPage:
        return [
          IconButton(
            icon: const Icon(Icons.arrow_circle_down),
            onPressed: () => vm.more!(),
          )
        ];
      case NavItem.patternsPage:
        return [
          IconButton(
            icon: const Icon(Icons.arrow_circle_down),
            onPressed: () => vm.more!(),
          )
        ];
      default:
        return [];
    }
  }
}

void speak(String text) => flutterTts.speak(text);

extension FirstWhereOrNullExtension<E> on Iterable<E> {
  E? firstWhereOrNull(bool Function(E) test) {
    for (E element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}

(int, int) getPreferredRangeFromArray(
    int index, int length, int preferredLength) {
  int start, end;
  if (length < preferredLength) {
    start = 0;
    end = length;
  } else {
    start = index - preferredLength ~/ 2;
    end = index + preferredLength ~/ 2;
    if (start < 0) {
      end -= start;
      start = 0;
    }
    if (end > length) {
      start -= end - length;
      end = length;
    }
  }
  return (start, end);
}
