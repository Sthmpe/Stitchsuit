import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/chat_thread.dart';
import '../../../data/repositories/chat_repository.dart';

part 'threads_event.dart';
part 'threads_state.dart';

class ThreadsBloc extends Bloc<ThreadsEvent, ThreadsState> {
  final ChatRepository repo;

  ThreadsBloc({required this.repo}) : super(const ThreadsState.loading()) {
    on<ThreadsRequested>(_onRequested);
    on<ThreadOpened>(_onThreadOpened);
    on<ThreadPreviewPatched>(_onPreviewPatched);
    on<ThreadsQueryChanged>(_onQueryChanged);
    on<ThreadsFilterChanged>(_onFilterChanged);
    on<ThreadPinToggled>(_onPinToggled);
  }

  Future<void> _onRequested(ThreadsRequested e, Emitter<ThreadsState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final items = await repo.fetchThreads();
      final sorted = _sorted(items);
      emit(state.copyWith(
        isLoading: false,
        all: sorted,
        visible: _apply(sorted, state.filter, state.query),
      ));
    } catch (err) {
      emit(state.copyWith(isLoading: false, error: err.toString()));
    }
  }

  void _onThreadOpened(ThreadOpened e, Emitter<ThreadsState> emit) {
    final list = state.all.map((t) => t.id == e.chatId ? t.copyWith(unreadCount: 0) : t).toList();
    final sorted = _sorted(list);
    emit(state.copyWith(all: sorted, visible: _apply(sorted, state.filter, state.query)));
  }

  void _onPreviewPatched(ThreadPreviewPatched e, Emitter<ThreadsState> emit) {
    final list = state.all.map((t) {
      if (t.id != e.chatId) return t;
      return t.copyWith(lastMessagePreview: e.preview, lastActivity: e.activity);
    }).toList();
    final sorted = _sorted(list);
    emit(state.copyWith(all: sorted, visible: _apply(sorted, state.filter, state.query)));
  }

  void _onQueryChanged(ThreadsQueryChanged e, Emitter<ThreadsState> emit) {
    emit(state.copyWith(
      query: e.query,
      visible: _apply(state.all, state.filter, e.query),
    ));
  }

  void _onFilterChanged(ThreadsFilterChanged e, Emitter<ThreadsState> emit) {
    emit(state.copyWith(
      filter: e.filter,
      visible: _apply(state.all, e.filter, state.query),
    ));
  }

  void _onPinToggled(ThreadPinToggled e, Emitter<ThreadsState> emit) {
    final list = state.all.map((t) => t.id == e.chatId ? t.copyWith(pinned: !t.pinned) : t).toList();
    final sorted = _sorted(list);
    emit(state.copyWith(all: sorted, visible: _apply(sorted, state.filter, state.query)));
  }

  List<ChatThread> _sorted(List<ChatThread> list) {
    final l = [...list];
    l.sort((a, b) {
      if (a.pinned != b.pinned) return b.pinned ? 1 : -1; // pinned first
      return b.lastActivity.compareTo(a.lastActivity);     // recent first
    });
    return l;
  }

  List<ChatThread> _apply(List<ChatThread> all, ChatListFilter f, String q) {
    Iterable<ChatThread> v = all;
    if (f == ChatListFilter.unread) {
      v = v.where((t) => t.unreadCount > 0);
    } else if (f == ChatListFilter.pinned) {
      v = v.where((t) => t.pinned);
    }
    if (q.isNotEmpty) {
      final qq = q.toLowerCase();
      v = v.where((t) =>
          t.title.toLowerCase().contains(qq) ||
          t.subtitle.toLowerCase().contains(qq) ||
          t.lastMessagePreview.toLowerCase().contains(qq));
    }
    return v.toList();
  }
}
