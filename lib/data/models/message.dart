import 'package:equatable/equatable.dart';

enum MessageSender { customer, tailor }
enum MessageStatus { sending, sent, delivered, read }

class Message extends Equatable {
  final String id;
  final String chatId;
  final MessageSender sender;
  final String text;
  final DateTime timestamp;
  final MessageStatus status; // for customer-sent messages

  const Message({
    required this.id,
    required this.chatId,
    required this.sender,
    required this.text,
    required this.timestamp,
    this.status = MessageStatus.read,
  });

  Message copyWith({MessageStatus? status}) => Message(
    id: id,
    chatId: chatId,
    sender: sender,
    text: text,
    timestamp: timestamp,
    status: status ?? this.status,
  );

  @override
  List<Object?> get props => [id, chatId, sender, text, timestamp, status];
}
