import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../core/constants/ui_constants.dart';
import '../app_screens/home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isCheckedone  = false;
  bool _isCheckedtwo = false;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Passwords do not match'),
          backgroundColor: Theme.of(context).primaryColor
        ),
      );
      return;
    }

    if (!_isCheckedtwo) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You must agree to the terms and conditions'),
            backgroundColor: Theme.of(context).primaryColor),
      );
      return;
    }
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all required fields'),
            backgroundColor: Theme.of(context).primaryColor
        ),
      );
      return;
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (userCredential.user != null) {
        await userCredential.user!.updateDisplayName(_nameController.text.trim());
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      String message = '';

      switch (e.code) {
        case 'weak-password':
          message = 'The password is too weak';
          break;
        case 'email-already-in-use':
          message = 'This email is already registered';
          break;
        case 'invalid-email':
          message = 'Invalid email address';
          break;
        default:
          message = 'An error occurred during sign up';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message),   backgroundColor: Theme.of(context).primaryColor),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An unexpected error occurred'),
        backgroundColor: Theme.of(context).primaryColor),
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
      body:Center(
        child: Column(
          children: [
            Text(
              "Traveller Sign Up",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            SizedBox(
              width: 347.w,
              height: 45.h,
              child: TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFe5e5e5),
                  hintText: "Name",
                  labelStyle: Theme.of(context).textTheme.labelSmall
                      ?.copyWith(color: Color(0xFF596C86)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            SizedBox(
              height: 45.h,
              width: 347.w,
              child: TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFe5e5e5),
                  hintText: "Email",
                  labelStyle: Theme.of(context).textTheme.labelSmall
                      ?.copyWith(color: Color(0xFF596c86)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            SizedBox(
              height: 45.h,
              width: 347.w,
              child: TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFe5e5e5),
                  hintText: "Phone",
                  labelStyle: Theme.of(context).textTheme.labelSmall
                      ?.copyWith(color: Color(0xFF596c86)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            SizedBox(
              width: 347.w,
              height: 45.h,
              child: TextFormField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFe5e5e5),
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
            SizedBox(height: 10.h),
            SizedBox(
              width: 347.w,
              height: 45.h,
              child: TextFormField(
                controller: _confirmPasswordController,
                obscureText: !_isConfirmPasswordVisible,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFe5e5e5),
                  hintText: "Varify Password",
                  labelStyle: Theme.of(context).textTheme.labelSmall
                      ?.copyWith(color: Color(0xFF596c86)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                      });
                    },
                    icon: Icon(
                      _isConfirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Theme.of(context).primaryColor,
                      size: 35,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
             Row(
               children: [
                  SizedBox(width: 15.w),
                 Checkbox(
                    value: _isCheckedone,
                    onChanged: (bool? value) {
                      setState(() {
                        _isCheckedone = value ?? false;
                      });
                    },
                    checkColor: Color(0xFF2973B2),
                    side: BorderSide(color:Color(0xFFe5e5e5),),
                    fillColor: WidgetStateProperty.all(Color(0xFFe5e5e5),),
                  ),
                  SizedBox(width: 5.w),
                 Text(
                   "Send me information about new services, deals\n or recommendations by Email.",
                   style: Theme.of(context).textTheme.labelSmall
                       ?.copyWith(color: Color(0xFF002347),
                   fontSize: 12.sp),
                 ),
               ],
             ),
            SizedBox(height: 10.h),
             Row(
               children: [
                  SizedBox(width: 15.w),
                 SizedBox(
                   child: Checkbox(
                      value: _isCheckedtwo,
                      onChanged: (bool? value) {
                        setState(() {
                          _isCheckedtwo= value ?? false;
                        });
                      },
                      checkColor: Color(0xFF2973B2),
                      side: BorderSide(color:Color(0xFFe5e5e5),),
                      fillColor: WidgetStateProperty.all(Color(0xFFe5e5e5),),
                    ),
                 ),
                  SizedBox(width: 5.w),
                 Text(
                   "I am 17 years old or older and agree to the\n terms and Privacy Policy.*",
                   style: Theme.of(context).textTheme.labelSmall
                       ?.copyWith(color: Color(0xFF002347),
                   fontSize: 12.sp),
                 ),
               ],
             ),
            SizedBox(height: 15.h),
            ElevatedButton(
              onPressed: _signUp,
              child: SizedBox(
                width: 322.w,
                height: 59.h,
                child: Center(
                  child: Text(
                    "Done",
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Colors.white,
                      fontSize: 32.sp,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h,),
            Text(
              "Another way to sign up",
              style: Theme.of(context).textTheme.labelSmall
                  ?.copyWith(color: Color(0xFF596C86)),
            ),
            SizedBox(height: 10.h,),
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
          ],
        ),
      ),
    );
  }
}
