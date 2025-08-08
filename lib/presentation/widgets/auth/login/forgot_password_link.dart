import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../../../screens/auth/forgot_password_screen.dart';

class ForgotPasswordLink extends StatelessWidget {
  const ForgotPasswordLink({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () => Get.to(ForgotPasswordScreen()),
        child: AutoSizeText(
          'Forgot Password?',
          style: GoogleFonts.nunitoSans(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFFA54600),
          ),
          maxLines: 1,
        ),
      ),
    );
  }
}


