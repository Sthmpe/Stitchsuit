import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      body: Center(
        child: Text(
          'Profile (Coming soon)',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Color(0xFF5F6368),
          ),
        ),
      ),
    );
  }
}
