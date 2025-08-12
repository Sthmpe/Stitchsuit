part of 'threads_bloc.dart';

enum ChatListFilter { all, unread, pinned }

abstract class ThreadsEvent extends Equatable {
  const ThreadsEvent();
  @override
  List<Object?> get props => [];
}

class ThreadsRequested extends ThreadsEvent {
  const ThreadsRequested();
}

class ThreadOpened extends ThreadsEvent {
  final String chatId;
  const ThreadOpened(this.chatId);
  @override
  List<Object?> get props => [chatId];
}

class ThreadPreviewPatched extends ThreadsEvent {
  final String chatId;
  final String preview;
  final DateTime activity;
  const ThreadPreviewPatched({required this.chatId, required this.preview, required this.activity});
  @override
  List<Object?> get props => [chatId, preview, activity];
}

class ThreadsQueryChanged extends ThreadsEvent {
  final String query;
  const ThreadsQueryChanged(this.query);
  @override
  List<Object?> get props => [query];
}

class ThreadsFilterChanged extends ThreadsEvent {
  final ChatListFilter filter;
  const ThreadsFilterChanged(this.filter);
  @override
  List<Object?> get props => [filter];
}

class ThreadPinToggled extends ThreadsEvent {
  final String chatId;
  const ThreadPinToggled(this.chatId);
  @override
  List<Object?> get props => [chatId];
}
