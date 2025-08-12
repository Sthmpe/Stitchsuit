import 'package:equatable/equatable.dart';
import '../../../data/models/inspiration_item.dart';

enum InspirationStatus { loading, success, failure }

class InspirationState extends Equatable {
  final InspirationStatus status;
  final List<InspirationItem> all;
  final List<InspirationItem> filtered;
  final String query;
  final String selectedCategory;
  final Set<String> savedIds;
  final int accentStep; // drives gradient animation
  final String? error;

  const InspirationState({
    this.status = InspirationStatus.loading,
    this.all = const [],
    this.filtered = const [],
    this.query = '',
    this.selectedCategory = 'All',
    this.savedIds = const {},
    this.accentStep = 0,
    this.error,
  });

  InspirationState copyWith({
    InspirationStatus? status,
    List<InspirationItem>? all,
    List<InspirationItem>? filtered,
    String? query,
    String? selectedCategory,
    Set<String>? savedIds,
    int? accentStep,
    String? error,
  }) {
    return InspirationState(
      status: status ?? this.status,
      all: all ?? this.all,
      filtered: filtered ?? this.filtered,
      query: query ?? this.query,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      savedIds: savedIds ?? this.savedIds,
      accentStep: accentStep ?? this.accentStep,
      error: error,
    );
  }

  @override
  List<Object?> get props =>
      [status, all, filtered, query, selectedCategory, savedIds, accentStep, error];
}
