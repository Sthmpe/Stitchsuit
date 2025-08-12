import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../data/models/chat_thread.dart'; 

class ChatTile extends StatelessWidget {
  final ChatThread thread;
  final VoidCallback onTap;
  final VoidCallback? onLongPress; // NEW

  const ChatTile({
    super.key,
    required this.thread,
    required this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final brand = Theme.of(context).primaryColor;
    final time = _formatTime(thread.lastActivity);

    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress, // NEW
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFFE9ECEF)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        child: Row(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                CircleAvatar(
                  radius: 22.r,
                  backgroundColor: _colorFromSeed(thread.colorSeed).withOpacity(.13),
                  child: Text(
                    thread.title.isNotEmpty ? thread.title[0] : '?',
                    style: TextStyle(color: brand, fontWeight: FontWeight.w800, fontSize: 16.sp),
                  ),
                ),
                if (thread.online)
                  Positioned(
                    right: -1.w,
                    bottom: -1.w,
                    child: Container(
                      width: 10.w,
                      height: 10.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2.w),
                      ),
                    ),
                  ),
                if (thread.pinned)
                  Positioned(
                    top: -2.h,
                    left: -4.w,
                    child: Icon(Icons.push_pin, size: 14.sp, color: const Color(0xFF6B7280)),
                  ),
              ],
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Expanded(
                      child: Text(
                        thread.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w800, color: const Color(0xFF111827)),
                      ),
                    ),
                    Text(time, style: TextStyle(fontSize: 11.sp, color: const Color(0xFF6B7280), fontWeight: FontWeight.w700)),
                  ]),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          thread.lastMessagePreview,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: const Color(0xFF6B7280),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      if (thread.unreadCount > 0)
                        Container(
                          margin: EdgeInsets.only(left: 8.w),
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                          decoration: BoxDecoration(
                            color: brand,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Text(
                            thread.unreadCount.toString(),
                            style: TextStyle(color: Colors.white, fontSize: 10.sp, fontWeight: FontWeight.w800),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _colorFromSeed(int seed) {
    final colors = [
      const Color(0xFF8B5CF6),
      const Color(0xFF10B981),
      const Color(0xFF6366F1),
      const Color(0xFFF59E0B),
      const Color(0xFFEC4899),
      const Color(0xFF14B8A6),
      const Color(0xFFEF4444),
    ];
    return colors[seed % colors.length];
  }

  String _formatTime(DateTime dt) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final thatDay = DateTime(dt.year, dt.month, dt.day);
    if (thatDay == today) {
      return DateFormat('HH:mm').format(dt);
    } else if (today.difference(thatDay).inDays == 1) {
      return 'Yesterday';
    } else {
      return DateFormat('d MMM').format(dt);
    }
  }
}
