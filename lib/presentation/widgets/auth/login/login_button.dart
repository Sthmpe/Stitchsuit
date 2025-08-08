import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../logic/blocs/login/login_bloc.dart';
import '../../../../logic/blocs/login/login_event.dart';
import '../../../../logic/blocs/login/login_state.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) {
        if (previous is LoginFormState && current is LoginFormState) {
          return previous.isFormValid != current.isFormValid;
        }
        return previous.runtimeType != current.runtimeType;
      },
      builder: (context, state) {
        final isLoading = state is LoginLoading;
        final isFormValid = state is LoginFormState && state.isFormValid;

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
              onTap: isLoading || !isFormValid
                  ? null
                  : () {
                      context.read<LoginBloc>().add(const LoginSubmitted());
                    },
              child: Center(
                child: isLoading
                    ? SizedBox(
                        width: 24.w,
                        height: 24.w,
                        child: const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : AutoSizeText(
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
      },
    );
  }
}


