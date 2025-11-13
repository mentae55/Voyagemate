import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:voyagemate/screens/login_and_registration_screens/sign_in_screen.dart';
import 'core/controllers/provider/trip_provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(
      create: (_) => TripProvider(),
      child: const MyApp(),

    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          theme: ThemeData(
            primaryColor: Color(0xFF2973B2),
            textTheme: TextTheme(
              labelSmall: TextStyle(
                fontSize: 15.sp,
                color: Color(0xFF002347),
                fontWeight: FontWeight.bold,
              ),
              labelLarge: TextStyle(
                fontSize: 45.sp,
                color: Color(0xFF002347),
                fontWeight: FontWeight.bold,
              ),
              titleLarge: TextStyle(
                fontSize: 32.sp,
                color: Color(0xFF002347),
                fontWeight: FontWeight.bold,
              ),
            ),

            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2973B2),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.r),
                ),
              ),
            ),
          ),
          debugShowCheckedModeBanner: false,
          home: child,
        );
      },
      child:SignInScreen()
    );
  }
}
