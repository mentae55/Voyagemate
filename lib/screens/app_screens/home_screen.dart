import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:voyagemate/core/controllers/provider/trip_provider.dart';
import 'package:voyagemate/core/widgets/custom_app_bar.dart';
import 'package:voyagemate/core/widgets/custom_card.dart';
import 'package:voyagemate/screens/app_screens/details_screen.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    final tripProvider = Provider.of<TripProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      tripProvider.fetchTrips();
    });

    return Scaffold(
      appBar: CustomAppBar(),
      body: Consumer<TripProvider>(
        builder: (context, tripProvider, _) {
          final trips = tripProvider.trips;

          if (trips.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            padding: EdgeInsets.all(16.w),
            itemCount: trips.length,
            itemBuilder: (context, index) {
              final destination = trips[index];
              return Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: CustomDestinationCard(
                  id: destination.id,
                  imageUrl: destination.imageUrl,
                  agency: destination.agencyName,
                  title: destination.title,
                  description: destination.description,
                  rating: destination.rating,
                  isSaved: destination.isSaved,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailsScreen(
                              trip: destination,
                              onSavedToggle: () {
                                tripProvider.toggleSaved(destination.id);
                              },
                            ),
                      ),
                    );
                  },
                  onSavedPressed: () {
                    tripProvider.toggleSaved(destination.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          trips[index].isSaved
                              ? '${destination.title} added to Saved!'
                              : '${destination.title} removed from Saved!',
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
