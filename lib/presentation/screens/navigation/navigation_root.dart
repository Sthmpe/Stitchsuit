import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/blocs/navigation/navigation_bloc.dart';
import '../../../logic/blocs/navigation/navigation_event.dart';
import '../../../logic/blocs/navigation/navigation_state.dart';

import '../../widgets/navigation/custom_bottom_nav.dart';
import '../home/home_screen.dart';
import '../bookings/booking_screen.dart';
import '../style_inspiration/style_inspiration_screen.dart';
import '../chats/chat_list_screen.dart';
import '../profile/profile_screen.dart';

class NavigationRoot extends StatelessWidget {
  const NavigationRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavigationBloc(),
      child: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          final List<Widget> screens = const [
            HomeScreen(),
            BookingScreen(),
            StyleInspirationScreen(),
            ChatsListScreen(), 
            ProfileScreen(),
          ];

          // Guard (just in case)
          final idx = (state.currentIndex >= 0 && state.currentIndex < screens.length)
              ? state.currentIndex
              : 0;

          return Scaffold(
            backgroundColor: const Color(0xFFF8F9FA),
            body: IndexedStack(
              index: idx,
              children: screens,
            ),
            bottomNavigationBar: CustomBottomNavBar(
              currentIndex: idx,
              onTap: (index) {
                final tab = NavigationTab.values[index];
                context.read<NavigationBloc>().add(NavigationTabSelected(tab));
              },
            ),
          );
        },
      ),
    );
  }
}
