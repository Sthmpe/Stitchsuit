import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class DateDivider extends StatelessWidget {
  final DateTime date;
  const DateDivider({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final that = DateTime(date.year, date.month, date.day);
    final label = that == today
        ? 'Today'
        : today.difference(that).inDays == 1
            ? 'Yesterday'
            : DateFormat('EEE, d MMM').format(date);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF1F5),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(label, style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w800, color: const Color(0xFF6B7280))),
    );
  }
}
