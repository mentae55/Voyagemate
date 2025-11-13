import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../core/constants/trips.dart';

class DetailsScreen extends StatefulWidget {
  final Trip trip;
  final VoidCallback? onSavedToggle;

  const DetailsScreen({super.key, required this.trip, this.onSavedToggle});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late bool isSaved;
  TripDetails? details;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    isSaved = widget.trip.isSaved;
    _fetchTripDetails();
  }

  Future<void> _fetchTripDetails() async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) {
        setState(() {
          errorMessage = 'User not logged in';
          isLoading = false;
        });
        return;
      }

      final docSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('DetailsTrips')
          .doc(widget.trip.id)
          .get();

      if (docSnapshot.exists) {
        setState(() {
          details = TripDetails.fromMap(docSnapshot.data()!);
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'Trip details not found';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error loading trip details: $e';
        isLoading = false;
      });
    }
  }

  void _onSavedPressed() {
    setState(() {
      isSaved = !isSaved;
    });

    widget.onSavedToggle?.call();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isSaved
              ? '${widget.trip.title} added to Saved!'
              : '${widget.trip.title} removed from Saved!',
        ),
        duration: const Duration(seconds: 1),
        backgroundColor: const Color(0xFF2973B2),
      ),
    );
  }

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
        title: Text(
          'Trip Details',
          style: Theme.of(
            context,
          ).textTheme.labelLarge?.copyWith(fontSize: 30.sp),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: _onSavedPressed,
            child: Icon(
              isSaved ? Icons.bookmark : Icons.bookmark_border,
              color: const Color(0xFF2973B2),
              size: 37.sp,
            ),
          ),
          SizedBox(width: 8.w),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64.r, color: Colors.red),
                  SizedBox(height: 16.h),
                  Text(
                    errorMessage!,
                    style: TextStyle(fontSize: 16.sp),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.h),
                  ElevatedButton(
                    onPressed: _fetchTripDetails,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              child: details != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (details!.heroImage.isNotEmpty)
                          Image.asset(
                            details!.heroImage,
                            width: double.infinity,
                            height: 220.h,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                widget.trip.imageUrl,
                                width: double.infinity,
                                height: 220.h,
                                fit: BoxFit.cover,
                              );
                            },
                          )
                        else
                          Image.asset(
                            widget.trip.imageUrl,
                            width: double.infinity,
                            height: 220.h,
                            fit: BoxFit.cover,
                          ),
                        Padding(
                          padding: EdgeInsets.all(16.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                details!.title,
                                style: TextStyle(
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                widget.trip.agencyName,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: const Color(0xFF596C86),
                                ),
                              ),
                              SizedBox(height: 12.h),
                              Row(
                                children: [
                                  Icon(Icons.location_on, size: 18.sp),
                                  SizedBox(width: 6.w),
                                  Text(details!.location),
                                  SizedBox(width: 16.w),
                                  Icon(Icons.timer, size: 18.sp),
                                  SizedBox(width: 6.w),
                                  Text(widget.trip.duration),
                                ],
                              ),
                              SizedBox(height: 12.h),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.orange,
                                    size: 18.sp,
                                  ),
                                  SizedBox(width: 4.w),
                                  Text(
                                    '${details!.rating} (${details!.reviewCount} reviews)',
                                    style: TextStyle(fontSize: 13.sp),
                                  ),
                                ],
                              ),
                              SizedBox(height: 18.h),
                              if (details!.galleryImages.isNotEmpty)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Gallery:',
                                      style: TextStyle(
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 10.h),
                                    SizedBox(
                                      height: 48.h,
                                      child: ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            details!.galleryImages.length,
                                        itemBuilder: (context, index) => ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            8.r,
                                          ),
                                          child: Image.network(
                                            details!.galleryImages[index],
                                            height: 48.h,
                                            width: 48.w,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                                  return Container(
                                                    height: 48.h,
                                                    width: 48.w,
                                                    color: Colors.grey[300],
                                                    child: Icon(
                                                      Icons.error,
                                                      size: 24.r,
                                                    ),
                                                  );
                                                },
                                            loadingBuilder:
                                                (
                                                  context,
                                                  child,
                                                  loadingProgress,
                                                ) {
                                                  if (loadingProgress == null)
                                                    return child;
                                                  return Container(
                                                    height: 48.h,
                                                    width: 48.w,
                                                    color: Colors.grey[200],
                                                    child: Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                            strokeWidth: 2,
                                                          ),
                                                    ),
                                                  );
                                                },
                                          ),
                                        ),
                                        separatorBuilder: (_, __) =>
                                            SizedBox(width: 25.w),
                                      ),
                                    ),
                                    SizedBox(height: 18.h),
                                  ],
                                ),
                              Text(
                                'About the Destination:',
                                style: TextStyle(
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 12.h),
                              Text(
                                details!.aboutDestination,
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  color: const Color(0xFF7D848D),
                                  height: 1.3,
                                ),
                              ),
                              SizedBox(height: 14.h),
                              Text(
                                'Trip Schedule:',
                                style: TextStyle(
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              ...details!.scheduleItems
                                  .map(
                                    (item) => Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 4.h,
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '• ',
                                            style: TextStyle(
                                              fontSize: 15.sp,
                                              color: const Color(0xFF7D848D),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              item,
                                              style: TextStyle(
                                                color: const Color(0xFF7D848D),
                                                fontSize: 15.sp,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList(),
                              SizedBox(height: 14.h),
                              Text(
                                'Reviews:',
                                style: TextStyle(
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10.h),
                              ...details!.reviews.map(
                                (review) => Padding(
                                  padding: EdgeInsets.only(bottom: 12.h),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        child: Icon(Icons.person, size: 25.r),
                                        radius: 20.r,
                                      ),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              review.userName,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xFF04215E),
                                                fontSize: 15.sp,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  color: Colors.orange,
                                                  size: 14.sp,
                                                ),
                                                Text(
                                                  review.rating.toString(),
                                                  style: TextStyle(
                                                    fontSize: 13.sp,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              review.comment,
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                color: const Color(0xFF7D848D),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Add your Review",
                                  style: Theme.of(context).textTheme.labelMedium
                                      ?.copyWith(
                                        color: Color(0xFF8C8C8C),
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Center(
                                child: TextButton(
                                  onPressed: () {},
                                  child: RichText(
                                    text: TextSpan(
                                      text: "Wants to contact us?",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium
                                          ?.copyWith(
                                            color: Color(0xFF8C8C8C),
                                            fontSize: 13.sp,
                                          ),
                                      children: [
                                        TextSpan(
                                          text: "CLICK HERE",
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium
                                              ?.copyWith(
                                                color: Color(0xFF8C8C8C),
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text("Reservation"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Center(child: Text('Trip details not found!')),
            ),
    );
  }
}
