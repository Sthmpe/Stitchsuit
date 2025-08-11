import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/bloc/navigation/navigation_bloc.dart';
import '../../../logic/bloc/navigation/navigation_event.dart';
import '../../../logic/bloc/navigation/navigation_state.dart';
import '../home/home_screen.dart';
import '../bookings/booking_screen.dart';
import '../placeholders/style_inspiration_screen.dart';
import '../placeholders/chats_screen.dart';
import '../placeholders/profile_screen.dart';
import 'widgets/stitch_bottom_nav_bar.dart';

class MainNavigationScreen extends StatelessWidget {
  const MainNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavigationBloc(),
      child: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          final screens = <Widget>[
            const HomeScreen(),
            const BookingScreen(),
            const StyleInspirationScreen(),
            const ChatsScreen(),
            const ProfileScreen(),
          ];

          return Scaffold(
            backgroundColor: const Color(0xFFF8F9FA),
            body: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              switchInCurve: Curves.easeOut,
              switchOutCurve: Curves.easeIn,
              child: screens[state.currentIndex],
            ),
            bottomNavigationBar: StitchBottomNavBar(
              currentIndex: state.currentIndex,
              onItemTapped: (index) {
                context.read<NavigationBloc>().add(NavigationItemSelected(index));
              },
            ),
          );
        },
      ),
    );
  }
}