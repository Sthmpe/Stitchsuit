import 'package:equatable/equatable.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object?> get props => [];
}

class NavigationItemSelected extends NavigationEvent {
  final int selectedIndex;
  const NavigationItemSelected(this.selectedIndex);

  @override
  List<Object?> get props => [selectedIndex];
}