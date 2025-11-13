import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voyagemate/screens/login_and_registration_screens/verification_screen.dart';

import '../../core/constants/ui_constants.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.keyboard_backspace_outlined, size: 42.r),
          color: Theme.of(context).primaryColor,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0).w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(UiConstants.logo, width: 500.w, height: 210.h),
            SizedBox(height: 50.h),
            Text(
              "Enter your Email or phone number",
              style: Theme.of(
                context,
              ).textTheme.labelSmall?.copyWith(fontSize: 20.sp),
            ),
            SizedBox(height: 10.h),
            SizedBox(
              height: 50.h,
              child: TextFormField(
                controller: _controller,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFe9e9e9),
                  hintText: "Email or phone number",
                  labelStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Color(0xFF596c86),
                    fontWeight: FontWeight.w900,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Text(
              "We will send a verification code to this account",
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Color(0xFF596c86),
                fontWeight: FontWeight.bold,
                fontSize: 13.sp,
              ),
            ),
            SizedBox(height: 50.h),
            SizedBox(
              height: 60.h,
              width: 322.w,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VerificationScreen(),
                    ),
                  );
                },
                child: Text("Done"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
