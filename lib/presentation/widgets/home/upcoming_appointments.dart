import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpcomingAppointments extends StatelessWidget {
  const UpcomingAppointments({super.key});

  @override
  Widget build(BuildContext context) {
    final brand = Theme.of(context).primaryColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Upcoming Appointments',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w800, color: const Color(0xFF2D3748))),
        SizedBox(height: 16.h),
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14.r),
            //border: Border.all(color: const Color(0xFFE5E7EB)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                        color: brand.withOpacity(.12),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(Icons.calendar_today_rounded, color: brand, size: 20.sp),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Fitting Session',
                              style: TextStyle(
                                  fontSize: 16.sp, fontWeight: FontWeight.w800, color: const Color(0xFF2D3748))),
                          SizedBox(height: 4.h),
                          Text('Tomorrow, 2:00 PM • Ahmed Hassan',
                              style: TextStyle(
                                  fontSize: 12.sp, fontWeight: FontWeight.w600, color: const Color(0xFF5F6368))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: Icon(Icons.notifications_active_rounded, size: 16.sp, color: brand),
                label: Text('Remind',
                    style:
                        TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w800, color: brand)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
