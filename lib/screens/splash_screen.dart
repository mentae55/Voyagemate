import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voyagemate/core/constants/ui_constants.dart';
import 'package:voyagemate/screens/login_and_registration_screens/sign_in_screen.dart';

import 'app_screens/home_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      _navigate();
    });
  }

  void _navigate() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const SignInScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 200.h),
            Image.asset(UiConstants.logo),
            ListTile(
              trailing: Text(
                '“Your trusted travel companion”',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
            SizedBox(height: 100.h),
            SizedBox(
              width: 322.w,
              child: ElevatedButton(
                onPressed: _navigate,
                child: ListTile(
                  title: Text(
                    'GO TRAVEL',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  trailing: Image.asset("assets/icons/arrow.png"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
