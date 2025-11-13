import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:voyagemate/core/constants/ui_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:voyagemate/screens/login_and_registration_screens/sign_up_screen.dart';

import '../app_screens/home_screen.dart';
import 'forget_password.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  Future<void> _signIn() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: _emailController.text,
            password: _passwordController.text,
          );

      if (userCredential.user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid email or password. Please try again.'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      );
    }
  }

  Future<UserCredential?> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);
      if (userCredential.user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }
      return userCredential;
    } catch (e) {
      print("Google Sign-In Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Google sign-in failed. Try again."),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      );
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 130.h,
        actions: [
          Image.asset(UiConstants.logo, width: 268.w),
          SizedBox(width: 45.w),
        ],
      ),

      body: Center(
        child: SizedBox(
          width: 360.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                color: Color(0xFFc7e2e5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Traveller \n Sign In",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    SizedBox(
                      height: 45.h,
                      child: TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFbdd2d5),
                          hintText: "Email or phone ",
                          labelStyle: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(color: Color(0xFF596c86)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15.h),
                    SizedBox(
                      height: 45.h,
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFbdd2d5),
                          hintText: "Password",
                          labelStyle: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(color: Color(0xFF596c86)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide.none,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Theme.of(context).primaryColor,
                              size: 35,
                            ),
                          ),
                        ),
                      ),
                    ),
                    ListTile(
                      trailing: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForgetPassword(),
                            ),
                          );
                        },
                        child: Text(
                          "Forgot password ?",
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(color: Color(0xFF596C86)),
                        ),
                      ),
                    ),

                    SizedBox(height: 20.h),

                    ElevatedButton(
                      onPressed: _signIn,
                      child: SizedBox(
                        width: 325.w,
                        height: 60.h,
                        child: Center(
                          child: Text(
                            "Sign Up",
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: _signInWithGoogle,
                          icon: Image.asset("assets/icons/Google.png"),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Image.asset("assets/icons/Facebook.png"),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "I don’t have account ",
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Color(0xFF596C86),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.h),
              TextButton(
                onPressed: () {},
                child: Text(
                  "For company account click here  ",
                  style: Theme.of(
                    context,
                  ).textTheme.labelSmall?.copyWith(color: Color(0xFF596C86)),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
