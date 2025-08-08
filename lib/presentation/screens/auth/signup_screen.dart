import 'package:flutter/material.dart';
import 'package:flutter_cursor_application_1/presentation/screens/auth/login_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  static const Color primaryColor = Color(0xFFA54600);

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _validateFullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Full name is required';
    }
    if (value.trim().length < 2) {
      return 'Full name must be at least 2 characters';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor:  Color(0xFFFAFAFA),
        surfaceTintColor: Colors.transparent,
        iconTheme: IconThemeData(color: Color(0xFFA54600)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 10.h),
                _buildHeader(),
                SizedBox(height: 40.h),
                _buildInputFields(),
                SizedBox(height: 32.h),
                _buildSignUpButton(),
                SizedBox(height: 24.h),
                _buildSocialSignUp(),
                SizedBox(height: 32.h),
                _buildLoginLink(),
                SizedBox(height: 40.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          width: 80.w,
          height: 80.h,
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: primaryColor.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Icon(Icons.rocket_launch, color: Colors.white, size: 40.sp),
        ),
        SizedBox(height: 16.h),
        AutoSizeText(
          'StitchSuit',
          style: GoogleFonts.nunitoSans(
            fontSize: 28.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1A1A1A),
          ),
          maxLines: 1,
        ),
        SizedBox(height: 8.h),
        AutoSizeText(
          "Let's create your account",
          style: GoogleFonts.nunitoSans(
            fontSize: 16.sp,
            color: const Color(0xFF666666),
            fontWeight: FontWeight.w400,
          ),
          maxLines: 1,
        ),
      ],
    );
  }

  Widget _buildInputFields() {
    return Column(
      children: [
        _buildInputField(
          controller: _fullNameController,
          label: 'Full Name',
          hintText: 'Enter your full name',
          icon: Iconsax.user,
          validator: _validateFullName,
        ),
        SizedBox(height: 20.h),
        _buildInputField(
          controller: _emailController,
          label: 'Email Address',
          hintText: 'Enter your email',
          icon: Iconsax.sms,
          validator: _validateEmail,
          keyboardType: TextInputType.emailAddress,
        ),
        SizedBox(height: 20.h),
        _buildPasswordField(
          controller: _passwordController,
          label: 'Password',
          hintText: 'Create a password',
          obscureText: _obscurePassword,
          onToggle: () => setState(() => _obscurePassword = !_obscurePassword),
          validator: _validatePassword,
        ),
        SizedBox(height: 20.h),
        _buildPasswordField(
          controller: _confirmPasswordController,
          label: 'Confirm Password',
          hintText: 'Confirm your password',
          obscureText: _obscureConfirmPassword,
          onToggle: () => setState(
            () => _obscureConfirmPassword = !_obscureConfirmPassword,
          ),
          validator: _validateConfirmPassword,
        ),
      ],
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    required IconData icon,
    required String? Function(String?) validator,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          label,
          style: GoogleFonts.nunitoSans(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
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
            controller: controller,
            validator: validator,
            keyboardType: keyboardType,
            style: GoogleFonts.nunitoSans(
              fontSize: 16.sp,
              color: const Color(0xFF1A1A1A),
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: GoogleFonts.nunitoSans(
                fontSize: 16.sp,
                color: const Color(0xFF999999),
              ),
              prefixIcon: Icon(
                icon,
                color: const Color(0xFF666666),
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

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    required bool obscureText,
    required VoidCallback onToggle,
    required String? Function(String?) validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          label,
          style: GoogleFonts.nunitoSans(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
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
            controller: controller,
            validator: validator,
            obscureText: obscureText,
            style: GoogleFonts.nunitoSans(
              fontSize: 16.sp,
              color: const Color(0xFF1A1A1A),
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: GoogleFonts.nunitoSans(
                fontSize: 16.sp,
                color: const Color(0xFF999999),
              ),
              prefixIcon: Icon(
                Iconsax.lock,
                color: const Color(0xFF666666),
                size: 20.sp,
              ),
              suffixIcon: IconButton(
                onPressed: onToggle,
                icon: Icon(
                  obscureText ? Iconsax.eye_slash : Iconsax.eye,
                  color: const Color(0xFF666666),
                  size: 20.sp,
                ),
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

  Widget _buildSignUpButton() {
    return Container(
      width: double.infinity,
      height: 56.h,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.3),
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
              print('Sign up pressed');
            }
          },
          child: Center(
            child: AutoSizeText(
              'Sign Up',
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

  Widget _buildSocialSignUp() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(height: 1.h, color: const Color(0xFFE5E5E5)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: AutoSizeText(
                'or sign up with',
                style: GoogleFonts.nunitoSans(
                  fontSize: 14.sp,
                  color: const Color(0xFF999999),
                ),
                maxLines: 1,
              ),
            ),
            Expanded(
              child: Container(height: 1.h, color: const Color(0xFFE5E5E5)),
            ),
          ],
        ),
        SizedBox(height: 24.h),
        _buildSocialButton(
          icon: MdiIcons.google,
          text: 'Sign up with Google',
          iconColor:  Color(0xFFA54600),
          onTap: () => debugPrint('Google sign up pressed'),
        ),
        SizedBox(height: 16.h),
        _buildSocialButton(
          icon: MdiIcons.facebook,
          text: 'Sign up with Facebook',
          iconColor: Color(0xFF1877F2),
          onTap: () => debugPrint('Facebook sign up pressed'),
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String text,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return Container(
      width: double.infinity,
      height: 56.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE5E5E5), width: 1),
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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 24.sp, color: iconColor),
                SizedBox(width: 12.w),
                AutoSizeText(
                  text,
                  style: GoogleFonts.nunitoSans(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1A1A1A),
                  ),
                  maxLines: 1,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AutoSizeText(
          'Already have an account? ',
          style: GoogleFonts.nunitoSans(
            fontSize: 16.sp,
            color: const Color(0xFF666666),
          ),
          maxLines: 1,
        ),
        TextButton(
          onPressed: () => Get.to(LoginScreen()),
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size(2.w, 0),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: AutoSizeText(
            'Login',
            style: GoogleFonts.nunitoSans(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}
