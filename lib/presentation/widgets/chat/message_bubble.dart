import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/models/message.dart';

class MessageBubble extends StatelessWidget {
  final Message message;
  const MessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final brand = Theme.of(context).primaryColor;
    final isMe = message.sender == MessageSender.customer;

    final bg = isMe ? brand : Colors.white;
    final fg = isMe ? Colors.white : const Color(0xFF1A1A1A);
    final border = isMe ? Border.all(color: brand.withOpacity(.25)) : Border.all(color: const Color(0xFFE5E7EB));
    final align = isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final radius = isMe
        ? BorderRadius.only(
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(4.r),
            bottomLeft: Radius.circular(16.r),
            bottomRight: Radius.circular(16.r),
          )
        : BorderRadius.only(
            topLeft: Radius.circular(4.r),
            topRight: Radius.circular(16.r),
            bottomLeft: Radius.circular(16.r),
            bottomRight: Radius.circular(16.r),
          );

    return Column(
      crossAxisAlignment: align,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 3.h).copyWith(
            left: isMe ? 60.w : 6.w,
            right: isMe ? 6.w : 60.w,
          ),
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: radius,
            border: border,
          ),
          child: Text(
            message.text,
            style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w700, color: fg),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w).copyWith(
            left: isMe ? 0 : 12.w,
            right: isMe ? 12.w : 0,
          ),
          child: Row(
            mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Text(_time(message.timestamp), style: TextStyle(fontSize: 10.sp, color: const Color(0xFF9AA0A6), fontWeight: FontWeight.w700)),
              if (isMe) ...[
                SizedBox(width: 6.w),
                _statusIcon(message.status),
              ],
            ],
          ),
        ),
      ],
    );
  }

  String _time(DateTime dt) => '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';

  Widget _statusIcon(MessageStatus s) {
    IconData icon;
    switch (s) {
      case MessageStatus.sending: icon = Icons.access_time_rounded; break;
      case MessageStatus.sent: icon = Icons.check_rounded; break;
      case MessageStatus.delivered: icon = Icons.done_all_rounded; break;
      case MessageStatus.read: icon = Icons.done_all_rounded; break;
    }
    return Icon(icon, size: 14.sp, color: s == MessageStatus.read ? const Color(0xFF10B981) : const Color(0xFF9AA0A6));
  }
}
