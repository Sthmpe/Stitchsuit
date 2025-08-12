import 'package:flutter/material.dart';
import 'package:flutter_cursor_application_1/presentation/screens/bookings/booking_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'booking_tile.dart';

class BookingList extends StatelessWidget {
  final List<Booking> bookings;
  const BookingList({super.key, required this.bookings});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(bookings.length, (i) {
        final b = bookings[i];
        final isLast = i == bookings.length - 1;
        return Padding(
          padding: EdgeInsets.only(bottom: isLast ? 0 : 12.h),
          child: BookingTile(booking: b),
        );
      }),
    );
  }
}
