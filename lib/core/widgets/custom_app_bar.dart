import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../screens/app_screens/setting_screen.dart';
import '../constants/ui_constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 90.h,
      automaticallyImplyLeading: false,
      title: IconButton(
        onPressed: () {},
        icon: Image.asset("assets/icons/Messaging.png"),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: SizedBox(
            width: 130.w,
            height: 100.h,
            child: Image.asset(
              UiConstants.logo,
            ),
          ),
        ),

        SizedBox(width: 30.w),
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingScreen()),
            );
          },
          icon: Image.asset("assets/icons/set.png"),
        ),
        SizedBox(width: 5.w),
        Image.asset("assets/icons/ar.png"),
        SizedBox(width: 10),
      ],

      bottom: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          child: SizedBox(
            height: 45.h,
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Search for trips here",
                prefixIcon: IconButton(onPressed: () {  },
                    icon: Image.asset("assets/icons/search.png")),
                suffixIcon: IconButton(onPressed: () {  },
                    icon: Image.asset("assets/icons/filter.png")),
                contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 12.w),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18.r),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Color(0xFFCCD3DA)
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(150.h);
}
