import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

import 'package:online_book_store/firebase_options.dart';
import 'package:online_book_store/models/book.dart';
import 'package:online_book_store/screens/login_screen.dart';
import 'package:online_book_store/screens/main_screen.dart';
import 'package:online_book_store/screens/onboarding_screen.dart';
import 'package:online_book_store/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData().copyWith(
        scaffoldBackgroundColor: const Color(
          0xFFFDFDFD,
        ),
        appBarTheme: const AppBarTheme(
          color: Color(
            0xFFFDFDFD,
          ),
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme().copyWith(
          bodyLarge: const TextStyle(
            color: Color(0xFF06070D),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          bodyMedium: const TextStyle(
            color: Color(0xFF06070D),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          bodySmall: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12,
            color: Color(0xFF9D9D9D),
          ),
        ),
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          }
          if (snapshot.hasData) {
            return MainScreen();
          } else if (!snapshot.hasData) {
            login = true;
            return const OnBoardingScreen();
          }

          return const LoginScreen();
        },
      ),
    );
  }
}
