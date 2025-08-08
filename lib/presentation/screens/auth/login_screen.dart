import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../logic/blocs/login/login_bloc.dart';
import '../../../logic/blocs/login/login_state.dart';
import '../../screens/home/homepage.dart';
import '../../widgets/auth/login/logo_section.dart';
import '../../widgets/auth/login/welcome_text.dart';
import '../../widgets/auth/login/email_field.dart';
import '../../widgets/auth/login/password_field.dart';
import '../../widgets/auth/login/forgot_password_link.dart';
import '../../widgets/auth/login/login_button.dart';
import '../../widgets/auth/login/social_login_separator.dart';
import '../../widgets/auth/login/social_login_buttons.dart';
import '../../widgets/auth/login/signup_link.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            Get.offAll(HomePage());
          } else if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.all(16.w),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            );
          }
        },
        child: Scaffold(
          backgroundColor: const Color(0xFFF8F9FA),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  SizedBox(height: 60.h),
                  const LogoSection(),
                  SizedBox(height: 0.h),
                  const WelcomeText(),
                  SizedBox(height: 40.h),
                  const EmailField(),
                  SizedBox(height: 20.h),
                  const PasswordField(),
                  const ForgotPasswordLink(),
                  SizedBox(height: 24.h),
                  const LoginButton(),
                  SizedBox(height: 32.h),
                  const SocialLoginSeparator(),
                  SizedBox(height: 24.h),
                  const SocialLoginButtons(),
                  SizedBox(height: 40.h),
                  const SignUpLink(),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
