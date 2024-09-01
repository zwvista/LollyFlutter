class NavDrawerState {
  final NavItem? selectedItem;

  const NavDrawerState(this.selectedItem);
}

enum NavItem {
  searchPage,
  settingsPage,
  wordsUnitPage,
  phrasesUnitPage,
  wordsReviewPage,
  phrasesReviewPage,
  wordsTextbookPage,
  phrasesTextbookPage,
  wordsLangPage,
  phrasesLangPage,
  patternsPage,
  onlineTextbooksPage,
}
