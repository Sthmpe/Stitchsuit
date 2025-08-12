import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/inspiration_item.dart';
import '../../../data/repositories/inspiration_repository.dart';
import 'inspiration_state.dart';

class InspirationCubit extends Cubit<InspirationState> {
  final InspirationRepository repo;

  InspirationCubit(this.repo) : super(const InspirationState());

  // categories you show in the chips
  final List<String> categories =
      const ['All', 'Suit', 'Ankara', 'Linen', 'Tuxedo', 'Blazer', 'Pattern', 'Casual', 'Formal', 'Summer', 'Classic'];

  Future<void> load() async {
    emit(state.copyWith(status: InspirationStatus.loading));
    try {
      final items = await repo.fetchAll();
      emit(state.copyWith(
        status: InspirationStatus.success,
        all: items,
        filtered: _applyFilters(items, state.query, state.selectedCategory),
      ));
    } catch (e) {
      emit(state.copyWith(status: InspirationStatus.failure, error: e.toString()));
    }
  }

  void setQuery(String q) {
    final filtered = _applyFilters(state.all, q, state.selectedCategory);
    emit(state.copyWith(query: q, filtered: filtered));
  }

  void setCategory(String c) {
    final filtered = _applyFilters(state.all, state.query, c);
    emit(state.copyWith(selectedCategory: c, filtered: filtered));
  }

  void toggleSave(String id) {
    final s = Set<String>.from(state.savedIds);
    s.contains(id) ? s.remove(id) : s.add(id);
    emit(state.copyWith(savedIds: s));
  }

  // scroll-driven gradient step
  void setAccentStep(int step) {
    if (step != state.accentStep) {
      emit(state.copyWith(accentStep: step));
    }
  }

  List<InspirationItem> _applyFilters(
    List<InspirationItem> items,
    String query,
    String category,
  ) {
    final q = query.trim().toLowerCase();
    return items.where((item) {
      final matchesText = q.isEmpty ||
          item.title.toLowerCase().contains(q) ||
          item.tags.any((t) => t.toLowerCase().contains(q));
      final matchesCat = category == 'All' ||
          item.tags.map((t) => t.toLowerCase()).contains(category.toLowerCase());
      return matchesText && matchesCat;
    }).toList();
  }
}
