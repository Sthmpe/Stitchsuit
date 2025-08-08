import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSocialButton(
          'Continue with Google',
          MdiIcons.google,
          const Color(0xFFA54600),
          () {
            // TODO: Implement Google login
          },
        ),
        SizedBox(height: 16.h),
        _buildSocialButton(
          'Continue with Facebook',
          MdiIcons.facebook,
          const Color(0xFF1877F2),
          () {
            // TODO: Implement Facebook login
          },
        ),
      ],
    );
  }

  Widget _buildSocialButton(
    String text,
    IconData icon,
    Color iconColor,
    VoidCallback onTap,
  ) {
    return Container(
      width: double.infinity,
      height: 56.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12.r),
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: iconColor, size: 24.sp),
              SizedBox(width: 12.w),
              AutoSizeText(
                text,
                style: GoogleFonts.nunitoSans(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF1A1A1A),
                ),
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


