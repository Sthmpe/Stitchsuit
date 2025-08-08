import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_fonts/google_fonts.dart';

class LogoSection extends StatelessWidget {
  const LogoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80.w,
          height: 80.w,
          decoration: BoxDecoration(
            color: const Color(0xFFA54600),
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFA54600).withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Icon(Icons.rocket_launch, color: Colors.white, size: 40.sp),
        ),
        SizedBox(height: 12.h),
        AutoSizeText(
          'StitchSuit',
          style: GoogleFonts.nunitoSans(
            fontSize: 32.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1A1A1A),
          ),
          maxLines: 1,
        ),
      ],
    );
  }
}
