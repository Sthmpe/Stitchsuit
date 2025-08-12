import 'package:flutter/material.dart';
import 'package:flutter_cursor_application_1/presentation/screens/bookings/booking_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingTile extends StatelessWidget {
  final Booking booking;
  const BookingTile({super.key, required this.booking});

  Color get _stripeColor {
    switch (booking.status) {
      case BookingStatus.upcoming:
        return const Color(0xFF10B981); // green
      case BookingStatus.completed:
        return const Color(0xFF3B82F6); // blue
      case BookingStatus.cancelled:
        return const Color(0xFFEF4444); // red
    }
  }

  String get _statusText {
    switch (booking.status) {
      case BookingStatus.upcoming:
        return 'Upcoming';
      case BookingStatus.completed:
        return 'Completed';
      case BookingStatus.cancelled:
        return 'Cancelled';
    }
  }

  @override
  Widget build(BuildContext context) {
    final brand = Theme.of(context).primaryColor;

    return InkWell(
      borderRadius: BorderRadius.circular(14.r),
      onTap: () {
        // open booking details
      },
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          //border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: Row(
          children: [
            // subtle status stripe (minimal, not flashy)
            Container(
              width: 4.w,
              height: 100.h,
              decoration: BoxDecoration(
                color: _stripeColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14.r), bottomLeft: Radius.circular(14.r),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // title + status chip
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            booking.title,
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF111827),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                          decoration: BoxDecoration(
                            color: _stripeColor.withOpacity(.10),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Text(
                            _statusText,
                            style: TextStyle(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w800,
                              color: _stripeColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    // location
                    Text(
                      booking.location,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF5F6368),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    // meta: date/time
                    Row(
                      children: [
                        Icon(Icons.schedule_rounded, size: 16.sp, color: const Color(0xFF9AA0A6)),
                        SizedBox(width: 6.w),
                        Text(
                          _formatDateTime(booking.dateTime),
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF9AA0A6),
                          ),
                        ),
                        const Spacer(),
                        // optional quick action
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            minimumSize: Size(0, 0),
                            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            'Details',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w800,
                              color: brand,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dt) {
    // Sat, 10:30 AM style
    final w = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'][dt.weekday % 7];
    final h = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
    final m = dt.minute.toString().padLeft(2, '0');
    final am = dt.hour < 12 ? 'AM' : 'PM';
    return '$w, $h:$m $am';
  }
}
