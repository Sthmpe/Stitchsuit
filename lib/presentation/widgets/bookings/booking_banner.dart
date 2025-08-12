import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingBanner extends StatelessWidget {
  final VoidCallback onTap;
  const BookingBanner({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final brand = Theme.of(context).primaryColor;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Ink(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: brand.withOpacity(0.08),
          borderRadius: BorderRadius.circular(16.r),
          //border: Border.all(color: brand.withOpacity(0.18)),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: brand,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(Icons.edit_calendar_rounded, color: Colors.white, size: 20.sp),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text('Create a new booking',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF111827),
                  )),
            ),
            Icon(Icons.arrow_forward_rounded, color: brand, size: 18.sp),
          ],
        ),
      ),
    );
  }
}
