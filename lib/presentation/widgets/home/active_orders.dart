import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActiveOrders extends StatelessWidget {
  const ActiveOrders({super.key});

  @override
  Widget build(BuildContext context) {
    //final borderColor = const Color(0xFFE5E7EB);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Active Orders',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w800, color: const Color(0xFF2D3748))),
        SizedBox(height: 16.h),
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14.r),
            //border: Border.all(color: borderColor),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  _iconBox(context, Icons.schedule_rounded),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Classic Navy Suit',
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.w800, color: const Color(0xFF2D3748))),
                        SizedBox(height: 2.h),
                        Text('Ahmed Hassan • Est. 5 days',
                            style: TextStyle(
                                fontSize: 12.sp, fontWeight: FontWeight.w600, color: const Color(0xFF5F6368))),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 14.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Progress',
                      style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600, color: const Color(0xFF9AA0A6))),
                  Text('60%',
                      style: TextStyle(
                          fontSize: 12.sp, fontWeight: FontWeight.w800, color: Theme.of(context).primaryColor)),
                ],
              ),
              SizedBox(height: 8.h),
              ClipRRect(
                borderRadius: BorderRadius.circular(6.r),
                child: LinearProgressIndicator(
                  minHeight: 6.h,
                  value: .6,
                  backgroundColor: const Color(0xFFECEFF1),
                  valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _iconBox(BuildContext context, IconData icon) {
    final brand = Theme.of(context).primaryColor;
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: brand.withOpacity(.12),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Icon(icon, color: brand, size: 18.sp),
    );
  }
}
