import 'package:equatable/equatable.dart';

/// Tabs available in the bottom navigation
enum NavigationTab { home, bookings, inspiration, chats, profile }

/// Base class for navigation events
abstract class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object?> get props => [];
}

/// Event fired when a navigation tab is selected
class NavigationTabSelected extends NavigationEvent {
  final NavigationTab tab;

  const NavigationTabSelected(this.tab);

  @override
  List<Object?> get props => [tab];
}