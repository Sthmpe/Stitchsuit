import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../logic/blocs/login/login_bloc.dart';
import '../../../../logic/blocs/login/login_event.dart';
import '../../../../logic/blocs/login/login_state.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) {
        if (previous is LoginFormState && current is LoginFormState) {
          return previous.password != current.password ||
              previous.passwordError != current.passwordError ||
              previous.obscurePassword != current.obscurePassword;
        }
        return previous.runtimeType != current.runtimeType;
      },
      builder: (context, state) {
        String password = '';
        String? passwordError;
        bool obscure = true;

        if (state is LoginFormState) {
          password = state.password;
          passwordError = state.passwordError;
          obscure = state.obscurePassword;
        }

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
                initialValue: password,
                onChanged: (value) {
                  context.read<LoginBloc>().add(LoginPasswordChanged(value));
                },
                obscureText: obscure,
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
                      obscure ? Icons.visibility_off : Icons.visibility,
                      color: const Color(0xFF9CA3AF),
                      size: 20.sp,
                    ),
                    onPressed: () {
                      context
                          .read<LoginBloc>()
                          .add(const LoginPasswordVisibilityToggled());
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
            if (passwordError != null) ...[
              SizedBox(height: 8.h),
              AutoSizeText(
                passwordError,
                style: GoogleFonts.nunitoSans(
                  fontSize: 12.sp,
                  color: Colors.red,
                ),
                maxLines: 1,
              ),
            ],
          ],
        );
      },
    );
  }
}


