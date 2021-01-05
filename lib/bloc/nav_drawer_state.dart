class NavDrawerState {
  final NavItem selectedItem;

  const NavDrawerState(this.selectedItem);
}

enum NavItem {
  searchPage,
  settingsPage,
  wordsUnitPage,
  phrasesUnitPage,
  wordsTextbookPage,
  phrasesTextbookPage,
  wordsLangPage,
  phrasesLangPage,
  patternPage,
}
