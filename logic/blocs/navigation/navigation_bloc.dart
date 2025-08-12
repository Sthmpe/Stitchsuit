import 'package:flutter_bloc/flutter_bloc.dart';
import 'navigation_event.dart';
import 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationState.initial()) {
    on<NavigationTabSelected>(_onTabSelected);
  }

  void _onTabSelected(
    NavigationTabSelected event,
    Emitter<NavigationState> emit,
  ) {
    final int index = NavigationTab.values.indexOf(event.tab);
    emit(state.copyWith(currentTab: event.tab, currentIndex: index));
  }
}
