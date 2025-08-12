import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/bookings/booking_banner.dart';
import '../../widgets/bookings/booking_empty.dart';
import '../../widgets/bookings/booking_list.dart';
import '../../widgets/bookings/booking_segmented_tabs.dart';


enum BookingStatus { upcoming, completed, cancelled }

class Booking {
  final String id;
  final String title;
  final String location;
  final DateTime dateTime;
  final BookingStatus status;

  const Booking({
    required this.id,
    required this.title,
    required this.location,
    required this.dateTime,
    required this.status,
  });
}

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  int _tabIndex = 0; // 0: Upcoming, 1: History

  // mock data – replace from repo/api later
  List<Booking> get _all => [
        Booking(
          id: '1',
          title: 'Fitting with Tailor Ahmed',
          location: 'Grand Atelier, Downtown',
          dateTime: DateTime.now().add(const Duration(days: 1, hours: 2)),
          status: BookingStatus.upcoming,
        ),
        Booking(
          id: '2',
          title: 'Suit Delivery',
          location: 'Maison Couture',
          dateTime: DateTime.now().subtract(const Duration(days: 2)),
          status: BookingStatus.completed,
        ),
        Booking(
          id: '3',
          title: 'Consultation',
          location: 'Studio 11',
          dateTime: DateTime.now().subtract(const Duration(days: 5)),
          status: BookingStatus.cancelled,
        ),
      ];

  List<Booking> get _upcoming =>
      _all.where((b) => b.status == BookingStatus.upcoming).toList();

  List<Booking> get _history =>
      _all.where((b) => b.status != BookingStatus.upcoming).toList();

  @override
  Widget build(BuildContext context) {
    final brand = Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text('Bookings',
            style:
                TextStyle(fontWeight: FontWeight.w800, fontSize: 18.sp, color: const Color(0xFF111827))),
        actions: [
          IconButton(
            tooltip: 'Calendar',
            onPressed: () {}, // open calendar view later
            icon: Icon(Icons.calendar_today_rounded, size: 18.sp, color: const Color(0xFF6B7280)),
          ),
          IconButton(
            tooltip: 'Filter',
            onPressed: () {}, // open filter sheet later
            icon: Icon(Icons.tune_rounded, size: 20.sp, color: const Color(0xFF6B7280)),
          ),
          SizedBox(width: 6.w),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 100.h),
        children: [
          BookingBanner(onTap: () {
            // push new booking flow
          }),
          SizedBox(height: 16.h),
          BookingSegmentedTabs(
            index: _tabIndex,
            onChanged: (i) => setState(() => _tabIndex = i),
          ),
          SizedBox(height: 12.h),
          if (_tabIndex == 0)
            (_upcoming.isEmpty
                ? const BookingEmpty(
                    title: 'No upcoming bookings',
                    subtitle: 'Tap “Create booking” to schedule your next fitting.',
                  )
                : BookingList(bookings: _upcoming))
          else
            (_history.isEmpty
                ? const BookingEmpty(
                    title: 'No booking history',
                    subtitle: 'Completed and cancelled bookings will appear here.',
                  )
                : BookingList(bookings: _history)),
          SizedBox(height: 24.h),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: brand,
        foregroundColor: Colors.white,
        onPressed: () {
          // same as banner action
        },
        icon: Icon(Icons.add_rounded, size: 22.sp),
        label: Text('New Booking', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14.sp)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
