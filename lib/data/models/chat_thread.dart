import 'package:equatable/equatable.dart';

class ChatThread extends Equatable {
  final String id;
  final String title;         // Tailor or business name
  final String subtitle;      // e.g., specialty or tagline
  final bool online;
  final bool pinned;
  final int unreadCount;
  final DateTime lastActivity;
  final String lastMessagePreview;
  final int colorSeed;        // for avatar color

  const ChatThread({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.online,
    required this.pinned,
    required this.unreadCount,
    required this.lastActivity,
    required this.lastMessagePreview,
    required this.colorSeed,
  });

  ChatThread copyWith({
    bool? online,
    bool? pinned,
    int? unreadCount,
    DateTime? lastActivity,
    String? lastMessagePreview,
  }) {
    return ChatThread(
      id: id,
      title: title,
      subtitle: subtitle,
      online: online ?? this.online,
      pinned: pinned ?? this.pinned,
      unreadCount: unreadCount ?? this.unreadCount,
      lastActivity: lastActivity ?? this.lastActivity,
      lastMessagePreview: lastMessagePreview ?? this.lastMessagePreview,
      colorSeed: colorSeed,
    );
  }

  @override
  List<Object?> get props => [id, title, subtitle, online, pinned, unreadCount, lastActivity, lastMessagePreview, colorSeed];
}
