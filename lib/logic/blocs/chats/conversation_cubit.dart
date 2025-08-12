// import 'dart:async';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../data/models/message.dart';
// import '../../../data/repositories/chat_repository.dart';
// import 'conversation_bloc.dart';

// class ConversationCubit extends Cubit<ConversationState> {
//   final ChatRepository repo;
//   Timer? _typingTimer;

//   ConversationCubit({
//     required this.repo,
//     required String chatId,
//     required String title,
//     required bool online,
//   }) : super(ConversationState.initial(chatId));

//   // Future<void> load() async {
//   //   emit(state.copyWith(status: ConversationStatus.loading));
//   //   try {
//   //     final messages = await repo.fetchMessages(state.chatId);
//   //     emit(
//   //       state.copyWith(status: ConversationStatus.success, messages: messages),
//   //     );
//   //   } catch (e) {
//   //     emit(
//   //       state.copyWith(status: ConversationStatus.failure, error: e.toString()),
//   //     );
//   //   }
//   // }

//   Future<void> send(String text) async {
//     if (text.trim().isEmpty) return;
//     // optimistic add
//     final msg = await repo.sendMessage(state.chatId, text);
//     final updated = List<Message>.from(state.messages)..add(msg);
//     emit(state.copyWith(messages: updated));

//     // after a short delay, simulate tailor typing + reply
//     _simulateTailorReply();
//   }

//   void _simulateTailorReply() {
//     _typingTimer?.cancel();
//     emit(state.copyWith(tailorTyping: true));
//     _typingTimer = Timer(
//       const Duration(seconds: 1, milliseconds: 200),
//       () async {
//         final reply = _smartReply();
//         final list = List<Message>.from(state.messages)
//           ..add(
//             Message(
//               id: DateTime.now().microsecondsSinceEpoch.toString(),
//               chatId: state.chatId,
//               sender: MessageSender.tailor,
//               text: reply,
//               timestamp: DateTime.now(),
//             ),
//           );
//         emit(state.copyWith(messages: list, tailorTyping: false));
//       },
//     );
//   }

//   String _smartReply() {
//     // simple, context-aware reply generator
//     final last = state.messages.isNotEmpty
//         ? state.messages.last.text.toLowerCase()
//         : '';
//     if (last.contains('price') || last.contains('cost')) {
//       return 'For this build, we can do ₦85,000 – ₦110,000 depending on fabric.';
//     } else if (last.contains('measure') || last.contains('fitting')) {
//       return 'I can schedule a fitting tomorrow 2 PM or Saturday 10:30 AM. Which works?';
//     } else if (last.contains('fabric') || last.contains('color')) {
//       return 'I recommend mid-weight with a soft drape. Navy, charcoal, or an earth tone will sit nicely.';
//     } else if (last.contains('delivery') || last.contains('ready')) {
//       return 'Turnaround is 5–7 working days after fitting. I’ll keep you updated.';
//     }
//     return 'Noted 👍 I’ll share options and next steps shortly.';
//   }

//   @override
//   Future<void> close() {
//     _typingTimer?.cancel();
//     return super.close();
//   }
// }
