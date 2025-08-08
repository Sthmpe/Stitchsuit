import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../logic/blocs/login/login_bloc.dart';
import '../../../../logic/blocs/login/login_event.dart';
import '../../../../logic/blocs/login/login_state.dart';

class EmailField extends StatelessWidget {
  const EmailField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        String email = '';
        String? emailError;
        
        if (state is LoginFormState) {
          email = state.email;
          emailError = state.emailError;
        }

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
                initialValue: email,
                onChanged: (value) {
                  context.read<LoginBloc>().add(LoginEmailChanged(value));
                },
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
            if (emailError != null) ...[
              SizedBox(height: 8.h),
              AutoSizeText(
                emailError,
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
