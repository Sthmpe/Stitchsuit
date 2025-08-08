import 'package:flutter/material.dart';
import 'package:flutter_cursor_application_1/presentation/screens/auth/password_reset_success_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;

  static const Color primaryColor = Color(0xFFA54600);

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
        });
        Get.offAll(PasswordResetSuccessScreen());
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor:  Color(0xFFF5F5F5),
        surfaceTintColor: Colors.transparent,
        iconTheme: IconThemeData(color: Color(0xFFA54600)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8.h),

                // Padlock icon
                Center(
                  child: Container(
                    width: 80.w,
                    height: 80.h,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: [
                        BoxShadow(
                          color: primaryColor.withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.lock_outline,
                      size: 40.sp,
                      color: Colors.white,
                    ),
                  ),
                ),

                SizedBox(height: 32.h),

                // Title
                Center(
                  child: AutoSizeText(
                    'Forgot Password?',
                    style: GoogleFonts.nunitoSans(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey[800],
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                  ),
                ),

                SizedBox(height: 16.h),

                // Instruction text
                Center(
                  child: AutoSizeText(
                    'Don\'t worry! It happens. Please enter the email address associated with your account.',
                    style: GoogleFonts.nunitoSans(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[600],
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 3,
                  ),
                ),

                SizedBox(height: 40.h),

                // Main container
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        'Email Address',
                        style: GoogleFonts.nunitoSans(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[700],
                        ),
                      ),

                      SizedBox(height: 8.h),

                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: Colors.grey[300]!,
                            width: 1,
                          ),
                        ),
                        child: TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: _validateEmail,
                          decoration: InputDecoration(
                            hintText: 'Enter your email address',
                            hintStyle: GoogleFonts.nunitoSans(
                              fontSize: 14.sp,
                              color: Colors.grey[500],
                            ),
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              size: 20.sp,
                              color: Colors.grey[500],
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 16.h,
                            ),
                          ),
                          style: GoogleFonts.nunitoSans(
                            fontSize: 14.sp,
                            color: Colors.grey[800],
                          ),
                        ),
                      ),

                      SizedBox(height: 24.h),

                      SizedBox(
                        width: double.infinity,
                        height: 56.h,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _handleSubmit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shadowColor: primaryColor.withOpacity(0.3),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: _isLoading
                              ? SizedBox(
                                  width: 20.w,
                                  height: 20.h,
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                )
                              : AutoSizeText(
                                  'Send Reset Link',
                                  style: GoogleFonts.nunitoSans(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 32.h),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20.r),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFDF6F0),
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12.r),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: primaryColor.withOpacity(0.0),
                        ),
                        child: Center(
                          child: Icon(
                            MdiIcons.sendVariant,
                            size: 40.sp,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      AutoSizeText(
                        'We\'ll send you a secure link to reset your password',
                        style: GoogleFonts.nunitoSans(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[700],
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 40.h),

                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: GoogleFonts.nunitoSans(
                        fontSize: 12.sp,
                        color: Colors.grey[500],
                      ),
                      children: [
                        const TextSpan(text: 'Need help? '),
                        TextSpan(
                          text: 'Account Support',
                          style: GoogleFonts.nunitoSans(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
