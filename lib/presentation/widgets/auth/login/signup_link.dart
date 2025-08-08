import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../../../screens/auth/signup_screen.dart';

class SignUpLink extends StatelessWidget {
  const SignUpLink({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AutoSizeText(
          "Don't have an account? ",
          style: GoogleFonts.nunitoSans(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF6B7280),
          ),
          maxLines: 1,
        ),
        TextButton(
          onPressed: () => Get.to(SignUpScreen()),
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size(2.w, 0),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: AutoSizeText(
            'Sign Up',
            style: GoogleFonts.nunitoSans(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFFA54600),
            ),
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}


