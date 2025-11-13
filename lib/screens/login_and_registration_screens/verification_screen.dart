import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/ui_constants.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  @override
  Widget build(BuildContext context) {
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
              "Verification Code",
              style: Theme.of(
                context,
              ).textTheme.labelLarge?.copyWith(fontSize: 40.sp),
            ),
            SizedBox(height: 10.h),
            Text(
              "We have sent the verification code to you!",
              style: TextStyle(color: Color(0xFFB6B6B6), fontSize: 16.sp),
            ),
            SizedBox(height: 50.h,),

          ],
        ),
      ),
    );
  }
}
