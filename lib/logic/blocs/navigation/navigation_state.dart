import 'package:equatable/equatable.dart';
import 'navigation_event.dart';

class NavigationState extends Equatable {
  final NavigationTab currentTab;
  final int currentIndex;

  const NavigationState({
    required this.currentTab,
    required this.currentIndex,
  });

  factory NavigationState.initial() => const NavigationState(
        currentTab: NavigationTab.home,
        currentIndex: 0,
      );

  NavigationState copyWith({
    NavigationTab? currentTab,
    int? currentIndex,
  }) {
    return NavigationState(
      currentTab: currentTab ?? this.currentTab,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }

  @override
  List<Object?> get props => [currentTab, currentIndex];
}