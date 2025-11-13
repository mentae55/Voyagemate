import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../controllers/provider/trip_provider.dart';

class CustomDestinationCard extends StatelessWidget {

  final String imageUrl;
  final String agency;
  final String title;
  final String description;
  final double rating;
  final bool isSaved;
  final VoidCallback? onTap;
  final VoidCallback? onSavedPressed;
  final String id;

  const CustomDestinationCard({
    required this.id,
    super.key,
    required this.imageUrl,
    required this.agency,
    required this.title,
    required this.description,
    this.rating = 0.0,
    this.isSaved = false,
    this.onTap,
    this.onSavedPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 390.w,
        height: 317.h,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 260.h,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(imageUrl),
                          fit: BoxFit.cover,
                          onError: (exception, stackTrace) {
                          },
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.1),
                            ],
                          ),
                        ),
                      ),
                    ),

                    if (rating > 0)
                      Positioned(
                        bottom: 10.h,
                        right: 10.w,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(5, (index) {
                              return Icon(
                                index < rating.floor()
                                    ? Icons.star
                                    : Icons.star_border,
                                color: Colors.amber,
                                size: 16.sp,
                              );
                            }),
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              // Content Section
              Expanded(
                flex: 2,
                child: Container(
                  width: double.infinity,
                  height: 113.h,
                  color: Colors.white,
                  padding: EdgeInsets.all(10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            agency,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Color(0xFF596C86),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              context.read<TripProvider>().toggleSaved(id);
                            },
                            child: Icon(
                              isSaved
                                  ? Icons.bookmark
                                  : Icons.bookmark_border,
                              color: const Color(0xFF2973B2),
                              size: 37.sp,
                            ),
                          ),

                        ],
                      ),

                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: description.length > 60
                                    ? '${description.substring(0, 60)}... '
                                    : '$description ',
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  color: const Color(0xFF596C86),
                                  height: 1.3,
                                ),
                              ),
                              TextSpan(
                                text: 'More Details',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: const Color(0xFF2973B2),
                                  fontWeight: FontWeight.bold,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = onTap,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}