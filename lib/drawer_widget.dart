import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lolly_flutter/bloc/drawer_event.dart';
import 'package:lolly_flutter/bloc/nav_drawer_bloc.dart';
import 'package:lolly_flutter/bloc/nav_drawer_state.dart';

class NavDrawerWidget extends StatelessWidget {
  final String accountName;
  final String accountEmail;
  final List<_NavigationItem> _listItems = [
    _NavigationItem(true, null, null, null),
    _NavigationItem(false, NavItem.searchPage, "Home", Icons.home),
    _NavigationItem(false, NavItem.settingsPage, "Settings", Icons.home),
    _NavigationItem(
        false, NavItem.wordsUnitPage, "Words in Unit", Icons.person),
    _NavigationItem(
        false, NavItem.phrasesUnitPage, "Phrases in Unit", Icons.list),
    _NavigationItem(
        false, NavItem.wordsTextbookPage, "Words in Textbook", Icons.person),
    _NavigationItem(
        false, NavItem.phrasesTextbookPage, "Phrases in Textbook", Icons.list),
    _NavigationItem(
        false, NavItem.wordsLangPage, "Words in Language", Icons.person),
    _NavigationItem(
        false, NavItem.phrasesLangPage, "Phrases in Language", Icons.list),
    _NavigationItem(false, NavItem.patternPage, "Patterns in Language",
        Icons.shopping_cart),
  ];

  NavDrawerWidget(this.accountName, this.accountEmail);

  @override
  Widget build(BuildContext context) => Drawer(
          child: Container(
        child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: _listItems.length,
            itemBuilder: (BuildContext context, int index) =>
                BlocBuilder<NavDrawerBloc, NavDrawerState>(
                  builder: (BuildContext context, NavDrawerState state) =>
                      _buildItem(_listItems[index], state),
                )),
      ));

  Widget _buildItem(_NavigationItem data, NavDrawerState state) =>
      data.header ? _makeHeaderItem() : _makeListItem(data, state);

  Widget _makeHeaderItem() => UserAccountsDrawerHeader(
        accountName: Text(accountName, style: TextStyle(color: Colors.white)),
        accountEmail: Text(accountEmail, style: TextStyle(color: Colors.white)),
        decoration: BoxDecoration(color: Colors.indigo),
        currentAccountPicture: CircleAvatar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.amber,
          child: Icon(
            Icons.person,
            size: 54,
          ),
        ),
      );

  Widget _makeListItem(_NavigationItem data, NavDrawerState state) => Card(
        shape: ContinuousRectangleBorder(borderRadius: BorderRadius.zero),
        borderOnForeground: true,
        elevation: 0,
        margin: EdgeInsets.zero,
        child: Builder(
          builder: (BuildContext context) => ListTile(
            title: Text(
              data.title,
              style: TextStyle(
                color: data.item == state.selectedItem
                    ? Colors.green
                    : Colors.blueGrey,
              ),
            ),
            leading: Icon(
              data.icon,
              color: data.item == state.selectedItem
                  ? Colors.green
                  : Colors.blueGrey,
            ),
            onTap: () => _handleItemClick(context, data.item),
          ),
        ),
      );

  void _handleItemClick(BuildContext context, NavItem item) {
    BlocProvider.of<NavDrawerBloc>(context).add(NavigateTo(item));
    Navigator.pop(context);
  }
}

class _NavigationItem {
  final bool header;
  final NavItem item;
  final String title;
  final IconData icon;

  _NavigationItem(this.header, this.item, this.title, this.icon);
}
