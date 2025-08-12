part of 'conversation_bloc.dart';

abstract class ConversationEvent extends Equatable {
  const ConversationEvent();
  @override
  List<Object?> get props => [];
}

class ConversationStarted extends ConversationEvent {
  const ConversationStarted();
}

class ConversationMessageSent extends ConversationEvent {
  final String text;
  const ConversationMessageSent(this.text);
  @override
  List<Object?> get props => [text];
}

/// Ask the bloc to simulate a tailor reply (runs inside a handler)
class ConversationTailorReplyRequested extends ConversationEvent {
  final String userText;
  const ConversationTailorReplyRequested(this.userText);
  @override
  List<Object?> get props => [userText];
}
