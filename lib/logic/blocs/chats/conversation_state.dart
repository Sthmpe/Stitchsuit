part of 'conversation_bloc.dart';

class ConversationState extends Equatable {
  final String chatId;
  final List<Message> messages;
  final bool isLoading;
  final bool tailorTyping;

  const ConversationState({
    required this.chatId,
    required this.messages,
    required this.isLoading,
    required this.tailorTyping,
  });

  factory ConversationState.initial(String id) => ConversationState(
        chatId: id,
        messages: const [],
        isLoading: false,
        tailorTyping: false,
      );

  ConversationState copyWith({
    String? chatId,
    List<Message>? messages,
    bool? isLoading,
    bool? tailorTyping,
  }) {
    return ConversationState(
      chatId: chatId ?? this.chatId,
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      tailorTyping: tailorTyping ?? this.tailorTyping,
    );
  }

  @override
  List<Object?> get props => [chatId, messages, isLoading, tailorTyping];
}
