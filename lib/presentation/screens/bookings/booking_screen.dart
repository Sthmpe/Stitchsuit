import 'package:flutter/material.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      floatingActionButton: _buildCTA(context),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              _buildUpcomingBookings(),
              const SizedBox(height: 24),
              _buildBookingDetails(),
              const SizedBox(height: 24),
              _buildBookingHistory(),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFA54600),
            const Color(0xFFA54600).withOpacity(0.85),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: const [
          Icon(Icons.event_note_rounded, color: Colors.white),
          SizedBox(width: 12),
          Text(
            'Your Bookings',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w800,
              fontFamily: 'Nunito Sans',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingBookings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Upcoming',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            fontFamily: 'Nunito Sans',
          ),
        ),
        const SizedBox(height: 12),
        Column(
          children: List.generate(2, (index) => _upcomingItem(index)),
        ),
      ],
    );
  }

  Widget _upcomingItem(int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.store_mall_directory_outlined, color: Color(0xFFA54600)),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Elegance Tailors',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                    fontFamily: 'Nunito Sans',
                  ),
                ),
              ),
              Text(
                'Fri, 11:00 AM',
                style: TextStyle(color: Colors.black54, fontSize: 12, fontFamily: 'Nunito Sans'),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'Two-piece suit fitting',
            style: TextStyle(fontSize: 13, fontFamily: 'Nunito Sans'),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _chip('In 2 days', const Color(0xFFA54600).withOpacity(0.10), const Color(0xFFA54600)),
              const Spacer(),
              _actionButton('Reschedule', Colors.black87.withOpacity(0.04), Colors.black87),
              const SizedBox(width: 8),
              _actionButton('Cancel', const Color(0xFFA54600), Colors.white, filled: true),
            ],
          ),
        ],
      ),
    );
  }

  Widget _chip(String text, Color background, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w700, fontFamily: 'Nunito Sans'),
      ),
    );
  }

  Widget _actionButton(String text, Color color, Color textColor, {bool filled = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: filled ? color : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: filled ? textColor : color,
          fontSize: 12,
          fontWeight: FontWeight.w800,
          fontFamily: 'Nunito Sans',
        ),
      ),
    );
  }

  Widget _buildBookingDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Booking Details',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            fontFamily: 'Nunito Sans',
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Elegance Tailors • Fri, 11:00 AM',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                  fontFamily: 'Nunito Sans',
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Service: Custom suit fitting\nLocation: Victoria Island, Lagos\nNotes: Bring preferred fabric and sample image.',
                style: TextStyle(
                  fontSize: 13,
                  height: 1.45,
                  color: Colors.black87,
                  fontFamily: 'Nunito Sans',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBookingHistory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'History',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            fontFamily: 'Nunito Sans',
          ),
        ),
        const SizedBox(height: 12),
        Column(
          children: List.generate(3, (index) => _historyItem(index)),
        ),
      ],
    );
  }

  Widget _historyItem(int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Icon(Icons.check_circle, color: Color(0xFFA54600)),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Completed • Two-piece suit',
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14, fontFamily: 'Nunito Sans'),
                ),
                SizedBox(height: 6),
                Text(
                  'Delivered on 24 May 2025',
                  style: TextStyle(color: Colors.black54, fontSize: 12, fontFamily: 'Nunito Sans'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCTA(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {},
      backgroundColor: const Color(0xFFA54600),
      elevation: 4,
      icon: const Icon(Icons.add, color: Colors.white),
      label: const Text(
        'New Booking',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontFamily: 'Nunito Sans'),
      ),
    );
  }
}