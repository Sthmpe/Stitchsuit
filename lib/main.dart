import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/repositories/chat_repository.dart';
import 'logic/blocs/chats/threads_bloc.dart';      // ⬅️ add this
import 'presentation/screens/auth/login_screen.dart';

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
        return MultiRepositoryProvider(
          providers: [
            RepositoryProvider<ChatRepository>(
              create: (_) => MockChatRepository(),
            ),
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider<ThreadsBloc>(
                create: (ctx) => ThreadsBloc(
                  repo: ctx.read<ChatRepository>(),
                )..add(const ThreadsRequested()),   // ⬅️ load threads on startup
              ),
            ],
            child: GetMaterialApp(
              title: 'StitchSuit',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primaryColor: const Color(0xFFA54600),
                colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFA54600)),
                fontFamily: GoogleFonts.nunitoSans().fontFamily,
                scaffoldBackgroundColor: const Color(0xFFF8F9FA),
                appBarTheme: const AppBarTheme(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  elevation: 0,
                ),
              ),
              home: const LoginScreen(),
            ),
          ),
        );
      },
    );
  }
}
