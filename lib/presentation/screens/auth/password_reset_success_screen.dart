import 'package:flutter/material.dart';
import 'package:flutter_cursor_application_1/presentation/screens/auth/login_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PasswordResetSuccessScreen extends StatelessWidget {
  const PasswordResetSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              SizedBox(height: 80.h),
              _buildSuccessIcon(),
              SizedBox(height: 32.h),
              _buildTitle(),
              SizedBox(height: 16.h),
              _buildSubtext(),
              SizedBox(height: 40.h),
              _buildEmailIcon(),
              const Spacer(),
              _buildBackToLoginButton(),
              SizedBox(height: 16.h),
              _buildResendEmailButton(),
              SizedBox(height: 24.h),
              _buildFooterText(),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessIcon() {
    return Container(
      width: 120.w,
      height: 120.w,
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E8),
        borderRadius: BorderRadius.circular(60.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4CAF50).withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Icon(
        Icons.check_circle,
        color: const Color(0xFF4CAF50),
        size: 60.sp,
      ),
    );
  }

  Widget _buildTitle() {
    return AutoSizeText(
      'Check your email',
      style: GoogleFonts.nunitoSans(
        fontSize: 28.sp,
        fontWeight: FontWeight.w700,
        color: const Color(0xFF2D3748),
      ),
      textAlign: TextAlign.center,
      maxLines: 2,
    );
  }

  Widget _buildSubtext() {
    return AutoSizeText(
      "We've sent a password reset link to your email. Please check your inbox and follow the instructions to reset your password.",
      style: GoogleFonts.nunitoSans(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: const Color(0xFF718096),
        height: 1.5,
      ),
      textAlign: TextAlign.center,
      maxLines: 4,
    );
  }

  Widget _buildEmailIcon() {
    return Container(
      width: 120.w,
      height: 100.h,
      decoration: BoxDecoration(
        color: const Color(0xFFF7F3E9),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE2D5C4), width: 1),
      ),
      child: Icon(
        Icons.email_outlined,
        color: const Color(0xFFA54600),
        size: 60.sp,
      ),
    );
  }

  Widget _buildBackToLoginButton() {
    return Container(
      width: double.infinity,
      height: 56.h,
      decoration: BoxDecoration(
        color: const Color(0xFFA54600),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFA54600).withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: () {
            Get.offAll(
              () => const LoginScreen(), // Replace with your actual login screen widget
            );
          },
          child: Center(
            child: AutoSizeText(
              'Back to Login',
              style: GoogleFonts.nunitoSans(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResendEmailButton() {
    return Container(
      width: double.infinity,
      height: 56.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFA54600), width: 1.5),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: () {
            // TODO: Implement resend email functionality
          },
          child: Center(
            child: AutoSizeText(
              'Resend Email',
              style: GoogleFonts.nunitoSans(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFFA54600),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFooterText() {
    return GestureDetector(
      onTap: () {
        // TODO: Implement contact support functionality
      },
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: GoogleFonts.nunitoSans(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xFFA0AEC0),
          ),
          children: [
            const TextSpan(
              text: "Didn't receive the email? Check your spam folder or ",
            ),
            TextSpan(
              text: 'contact support',
              style: GoogleFonts.nunitoSans(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFFA54600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
