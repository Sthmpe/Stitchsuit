import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/message.dart';
import '../../../data/repositories/chat_repository.dart';
import 'threads_bloc.dart';

part 'conversation_event.dart';
part 'conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  final ChatRepository repo;
  final ThreadsBloc threadsBloc;

  ConversationBloc({
    required this.repo,
    required this.threadsBloc,
    required String chatId,
  }) : super(ConversationState.initial(chatId)) {
    on<ConversationStarted>(_onStarted);
    on<ConversationMessageSent>(_onSend);
    on<ConversationTailorReplyRequested>(_onTailorReplyRequested);
  }

  Future<void> _onStarted(
    ConversationStarted e,
    Emitter<ConversationState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final msgs = await repo.fetchMessages(state.chatId);
    emit(state.copyWith(isLoading: false, messages: msgs));
    // mark this thread as read
    threadsBloc.add(ThreadOpened(state.chatId));
  }

  Future<void> _onSend(
    ConversationMessageSent e,
    Emitter<ConversationState> emit,
  ) async {
    final text = e.text.trim();
    if (text.isEmpty) return;

    // optimistic send via repo
    final sent = await repo.sendMessage(state.chatId, text);
    emit(
      state.copyWith(messages: [...state.messages, sent], tailorTyping: false),
    );

    // Update threads list preview/time
    threadsBloc.add(
      ThreadPreviewPatched(
        chatId: state.chatId,
        preview: sent.text,
        activity: sent.timestamp,
      ),
    );

    // schedule simulated tailor reply (event-based, safe)
    add(ConversationTailorReplyRequested(text));
  }

  Future<void> _onTailorReplyRequested(
    ConversationTailorReplyRequested e,
    Emitter<ConversationState> emit,
  ) async {
    // show typing
    emit(state.copyWith(tailorTyping: true));

    await Future.delayed(const Duration(milliseconds: 1200));

    final replyText = _smartReply(e.userText);

    // ⬇️ Persist tailor reply in the repository (so it won't disappear)
    final reply = await repo.addTailorMessage(state.chatId, replyText);

    emit(
      state.copyWith(messages: [...state.messages, reply], tailorTyping: false),
    );

    // update thread preview/time + keep unread at 0 (chat is open)
    threadsBloc.add(
      ThreadPreviewPatched(
        chatId: state.chatId,
        preview: reply.text,
        activity: reply.timestamp,
      ),
    );
    threadsBloc.add(ThreadOpened(state.chatId));
  }

  String _smartReply(String lastUserText) {
    final last = lastUserText.toLowerCase();
    if (last.contains('price') || last.contains('cost')) {
      return 'For this build, we can do ₦85,000 – ₦110,000 depending on fabric.';
    } else if (last.contains('measure') || last.contains('fitting')) {
      return 'I can schedule a fitting tomorrow 2 PM or Saturday 10:30 AM. Which works?';
    } else if (last.contains('fabric') || last.contains('color')) {
      return 'I recommend mid-weight with a soft drape. Navy, charcoal, or an earth tone will sit nicely.';
    } else if (last.contains('delivery') || last.contains('ready')) {
      return 'Turnaround is 5–7 working days after fitting. I’ll keep you updated.';
    }
    return 'Noted 👍 I’ll share options and next steps shortly.';
  }
}
