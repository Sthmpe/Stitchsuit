import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_fonts/google_fonts.dart';

class SocialLoginSeparator extends StatelessWidget {
  const SocialLoginSeparator({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Container(height: 1, color: const Color(0xFFE5E7EB))),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: AutoSizeText(
            'or continue with',
            style: GoogleFonts.nunitoSans(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF6B7280),
            ),
            maxLines: 1,
          ),
        ),
        Expanded(child: Container(height: 1, color: const Color(0xFFE5E7EB))),
      ],
    );
  }
}


