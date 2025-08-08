import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'data/repositories/auth_repository.dart';
import 'presentation/screens/auth/login_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'StitchSuit',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.orange,
            primaryColor: const Color(0xFFA54600),
            fontFamily: GoogleFonts.nunitoSans().fontFamily,
          ),
          home: const LoginScreen(),
        );
      },
    );
  }
}
