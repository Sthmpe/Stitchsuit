import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      'Welcome back!',
      style: GoogleFonts.nunitoSans(
        fontSize: 18.sp,
        fontWeight: FontWeight.w400,
        color: const Color(0xFF1A1A1A),
      ),
      maxLines: 1,
    );
  }
}


