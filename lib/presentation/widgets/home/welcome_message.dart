import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeMessage extends StatelessWidget {
  const WelcomeMessage({super.key});

  @override
  Widget build(BuildContext context) {
    final brand = Theme.of(context).primaryColor;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: brand.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16.r),
        //border: Border.all(color: brand.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: brand, borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(Icons.waving_hand_rounded, color: Colors.white, size: 20.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hello David 👋',
                    style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w800, color: const Color(0xFF2D3748))),
                SizedBox(height: 4.h),
                Text('Ready to create your perfect suit?',
                    style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600, color: const Color(0xFF5F6368))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
