part of 'threads_bloc.dart';

class ThreadsState extends Equatable {
  final List<ChatThread> all;
  final List<ChatThread> visible;
  final bool isLoading;
  final String? error;
  final String query;
  final ChatListFilter filter;

  const ThreadsState({
    required this.all,
    required this.visible,
    required this.isLoading,
    required this.error,
    required this.query,
    required this.filter,
  });

  const ThreadsState.loading()
      : this(
          all: const [],
          visible: const [],
          isLoading: true,
          error: null,
          query: '',
          filter: ChatListFilter.all,
        );

  ThreadsState copyWith({
    List<ChatThread>? all,
    List<ChatThread>? visible,
    bool? isLoading,
    String? error,
    String? query,
    ChatListFilter? filter,
  }) {
    return ThreadsState(
      all: all ?? this.all,
      visible: visible ?? this.visible,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      query: query ?? this.query,
      filter: filter ?? this.filter,
    );
  }

  @override
  List<Object?> get props => [all, visible, isLoading, error, query, filter];
}
