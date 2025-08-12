import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final brand = Theme.of(context).primaryColor;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft, end: Alignment.bottomRight,
          colors: [brand, brand.withOpacity(0.85)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24.r),
          bottomRight: Radius.circular(24.r),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20.r,
            backgroundColor: Colors.white.withOpacity(0.18),
            child: Icon(Icons.person, color: Colors.white, size: 22.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('StitchSuit',
                  style: TextStyle(
                    color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w800,
                  )),
                SizedBox(height: 2.h),
                Text('Premium Tailoring Services',
                  style: TextStyle(
                    color: Colors.white70, fontSize: 12.sp, fontWeight: FontWeight.w600,
                  )),
              ],
            ),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(12.r),
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.all(8.w),
              child: Icon(Icons.notifications_outlined, color: Colors.white, size: 24.sp),
            ),
          ),
        ],
      ),
    );
  }
}
