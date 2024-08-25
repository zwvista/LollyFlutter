import 'package:bloc/bloc.dart';

import 'drawer_event.dart';
import 'nav_drawer_state.dart';

// https://blog.logrocket.com/introduction-flutter-bloc-8/
class NavDrawerBloc extends Bloc<NavDrawerEvent, NavDrawerState> {
  NavDrawerBloc() : super(NavDrawerState(NavItem.searchPage)) {
    on<NavigateTo>((event, emit) {
      if (event.destination != state.selectedItem) {
        emit(NavDrawerState(event.destination));
      }
    });
  }
}
