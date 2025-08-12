import 'package:flutter/material.dart';

import '../../widgets/home/active_orders.dart';
import '../../widgets/home/featured_vendors.dart';
import '../../widgets/home/header_section.dart';
import '../../widgets/home/home_search_bar.dart';
import '../../widgets/home/outfit_gallery.dart';
import '../../widgets/home/recent_activities.dart';
import '../../widgets/home/recommended_tailors.dart';
import '../../widgets/home/saved_tailors.dart';
import '../../widgets/home/upcoming_appointments.dart';
import '../../widgets/home/welcome_message.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Column(
          children: [
            const HeaderSection(),          // gradient header
            const HomeSearchBar(),          // search
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SizedBox(height: 20),
                    WelcomeMessage(),
                    SizedBox(height: 24),
                    OutfitGallery(),
                    SizedBox(height: 32),
                    RecommendedTailors(),
                    SizedBox(height: 32),
                    FeaturedVendors(),
                    SizedBox(height: 32),
                    ActiveOrders(),
                    SizedBox(height: 32),
                    SavedTailors(),
                    SizedBox(height: 32),
                    UpcomingAppointments(),
                    SizedBox(height: 32),
                    RecentActivities(),
                    SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar intentionally removed; provided by NavigationRoot
    );
  }
}
