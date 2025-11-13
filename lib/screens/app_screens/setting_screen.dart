import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voyagemate/screens/app_screens/profile_screen.dart';
import 'package:voyagemate/screens/app_screens/saved_trips_screen.dart';
import 'package:voyagemate/screens/app_screens/visited_trips_screen.dart';
import '../../core/constants/ui_constants.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          Image.asset(UiConstants.logo),
          SizedBox(width: 90.w),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0).w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Settings", style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 20.h),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },
              child: Row(
                children: [
                  Image.asset("assets/icons/person.png"),
                  SizedBox(width: 10.w),
                  RichText(
                    text: TextSpan(
                      text: 'Matilda Brown\n',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'matildabrown@mail.com',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40.h),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>VisitedTripsScreen()),
                );
              },
              child: Container(
                height: 50.h,
                width: 335.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: Color(0xFFCCD3DA),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 20.w),
                    Image.asset("assets/icons/road.png"),
                    SizedBox(width: 20.w),
                    Text("My trips", style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontSize: 18.sp,
                    )),
                  ],
                ),
              ),
            ),
            SizedBox(height: 80.h),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>SavedTripsScreen()),
                );
              },
              child: Container(
                height: 50.h,
                width: 335.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: Color(0xFFCCD3DA),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 20.w),
                    Image.asset("assets/icons/saved.png"),
                    SizedBox(width: 20.w),
                    Text("Saved trips", style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontSize: 18.sp,
                    )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
