import 'package:flutter/material.dart';
import 'package:flutter_cursor_application_1/presentation/screens/auth/forgot_password_screen.dart';
import 'package:flutter_cursor_application_1/presentation/screens/auth/signup_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 60.h),
                _buildLogoSection(),
                SizedBox(height: 0.h),
                _buildWelcomeText(),
                SizedBox(height: 40.h),
                _buildEmailField(),
                SizedBox(height: 20.h),
                _buildPasswordField(),
                //SizedBox(height: 12.h),
                _buildForgotPasswordLink(),
                SizedBox(height: 24.h),
                _buildLoginButton(),
                SizedBox(height: 32.h),
                _buildSocialLoginSeparator(),
                SizedBox(height: 24.h),
                _buildSocialLoginButtons(),
                SizedBox(height: 40.h),
                _buildSignUpLink(),
                SizedBox(height: 40.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogoSection() {
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

  Widget _buildWelcomeText() {
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

  Widget _buildEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          'Email Address',
          style: GoogleFonts.nunitoSans(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF1A1A1A),
          ),
          maxLines: 1,
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            controller: _emailController,
            validator: _validateEmail,
            keyboardType: TextInputType.emailAddress,
            style: GoogleFonts.nunitoSans(
              fontSize: 16.sp,
              color: const Color(0xFF1A1A1A),
            ),
            decoration: InputDecoration(
              hintText: 'Enter your email',
              hintStyle: GoogleFonts.nunitoSans(
                fontSize: 16.sp,
                color: const Color(0xFF9CA3AF),
              ),
              prefixIcon: Icon(
                Icons.email_outlined,
                color: const Color(0xFF9CA3AF),
                size: 20.sp,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 16.h,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          'Password',
          style: GoogleFonts.nunitoSans(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF1A1A1A),
          ),
          maxLines: 1,
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            controller: _passwordController,
            validator: _validatePassword,
            obscureText: _obscurePassword,
            style: GoogleFonts.nunitoSans(
              fontSize: 16.sp,
              color: const Color(0xFF1A1A1A),
            ),
            decoration: InputDecoration(
              hintText: 'Enter your password',
              hintStyle: GoogleFonts.nunitoSans(
                fontSize: 16.sp,
                color: const Color(0xFF9CA3AF),
              ),
              prefixIcon: Icon(
                Icons.lock_outline,
                color: const Color(0xFF9CA3AF),
                size: 20.sp,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  color: const Color(0xFF9CA3AF),
                  size: 20.sp,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 16.h,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForgotPasswordLink() {
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

  Widget _buildLoginButton() {
    return Container(
      width: double.infinity,
      height: 56.h,
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: () {
            if (_formKey.currentState!.validate()) {
              // TODO: Implement login logic
            }
          },
          child: Center(
            child: AutoSizeText(
              'Login',
              style: GoogleFonts.nunitoSans(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              maxLines: 1,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialLoginSeparator() {
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

  Widget _buildSocialLoginButtons() {
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

  Widget _buildSignUpLink() {
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
