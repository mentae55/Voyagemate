import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../core/constants/ui_constants.dart';
import '../../core/controllers/provider/trip_provider.dart';
import '../../core/widgets/custom_card.dart';
import 'details_screen.dart';
class VisitedTripsScreen extends StatelessWidget {
  const VisitedTripsScreen({super.key});

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
        toolbarHeight: 100.h,
        actions: [
          IconButton(onPressed: () {}, icon: Image.asset(UiConstants.logo)),
          SizedBox(width: 90.w),
        ],
        centerTitle: false,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(30.h),
          child: Text(
            "My Visited Trips",
            style: Theme
                .of(context)
                .textTheme
                .titleLarge,
          ),
        ),
      ),
      body: Consumer<TripProvider>(
        builder: (context, tripProvider, _) {
          final visitedTrips = tripProvider.visitedTrips;

          if (visitedTrips.isEmpty) {
            return const Center(child: Text("You have no visited trips yet."));
          }

          return ListView.builder(
            padding: EdgeInsets.all(16.w),
            itemCount: visitedTrips.length,
            itemBuilder: (context, index) {
              final trip = visitedTrips[index];
              return Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: CustomDestinationCard(
                  id: trip.id,
                  imageUrl: trip.imageUrl,
                  agency: trip.agencyName,
                  title: trip.title,
                  description: trip.description,
                  rating: trip.rating,
                  isSaved: trip.isSaved,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailsScreen(
                              trip: trip,
                              onSavedToggle: () {
                                tripProvider.toggleSaved(trip.id);
                              },
                            ),
                      ),
                    );
                  },
                  onSavedPressed: () {
                    tripProvider.toggleSaved(trip.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          trip.isSaved
                              ? '${trip.title} added to Saved!'
                              : '${trip.title} removed from Saved!',
                        ),
                        duration: const Duration(seconds: 1),
                        backgroundColor: const Color(0xFF2973B2),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
