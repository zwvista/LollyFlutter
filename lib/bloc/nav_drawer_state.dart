class NavDrawerState {
  final NavItem selectedItem;

  const NavDrawerState(this.selectedItem);
}

enum NavItem {
  homePage,
  wordsUnitPage,
  phrasesUnitPage,
  wordsTextbookPage,
  phrasesTextbookPage,
  wordsLangPage,
  phrasesLangPage,
  myCart,
}
