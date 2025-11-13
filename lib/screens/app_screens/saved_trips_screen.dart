import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:voyagemate/core/constants/ui_constants.dart';
import 'package:voyagemate/core/controllers/provider/trip_provider.dart';
import 'package:voyagemate/core/widgets/custom_card.dart';
import 'package:voyagemate/screens/app_screens/details_screen.dart';

class SavedTripsScreen extends StatelessWidget {
  const SavedTripsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tripsRef = FirebaseFirestore.instance
        .collection("users")
        .doc("USER_ID")
        .collection("trips");

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
            "My Saved Trips",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
      body: Consumer<TripProvider>(
        builder: (context, tripProvider, _) {
          final savedTrips = tripProvider.savedTrips;

          if (savedTrips.isEmpty) {
            return const Center(child: Text("You have no saved trips yet."));
          }

          return ListView.builder(
            padding: EdgeInsets.all(16.w),
            itemCount: savedTrips.length,
            itemBuilder: (context, index) {
              final trip = savedTrips[index];
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
                        builder: (context) => DetailsScreen(
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
                  }
                ),
              );
            },
          );
        },
      ),
    );
  }
}