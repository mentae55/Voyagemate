import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/ui_constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _nameController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset("assets/icons/back.png"),
        ),
        toolbarHeight: 90.h,
        actions: [
          IconButton(onPressed: () {}, icon: Image.asset(UiConstants.logo)),
          SizedBox(width: 90.w),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0).w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("My Account", style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 40.h),
            Center(child: Image.asset("assets/icons/personEdit.png")),
            SizedBox(height: 20.h),
            Text(
              "Full Name",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.h),
            SizedBox(
              height: 45.h,
              child: TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFCCD3DA),
                  hintText: "Matilda Brown",
                  labelStyle: Theme.of(context).textTheme.labelSmall
                      ?.copyWith(color: Color(0xFF596c86)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              "Email Address",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.h),
            SizedBox(
              height: 45.h,
              child: TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFCCD3DA),
                  hintText: "matildabrown@mail.com",
                  labelStyle: Theme.of(context).textTheme.labelSmall
                      ?.copyWith(color: Color(0xFF596c86)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
