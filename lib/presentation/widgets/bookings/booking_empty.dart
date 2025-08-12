import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingEmpty extends StatelessWidget {
  final String title;
  final String subtitle;

  const BookingEmpty({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 40.h),
      alignment: Alignment.center,
      child: Column(
        children: [
          Icon(Icons.event_busy_rounded, size: 42.sp, color: const Color(0xFF9AA0A6)),
          SizedBox(height: 10.h),
          Text(title,
              style: TextStyle(
                fontSize: 14.sp, fontWeight: FontWeight.w800, color: const Color(0xFF2D3748),
              )),
          SizedBox(height: 6.h),
          SizedBox(
            width: 280.w,
            child: Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.sp, fontWeight: FontWeight.w600, color: const Color(0xFF6B7280),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
