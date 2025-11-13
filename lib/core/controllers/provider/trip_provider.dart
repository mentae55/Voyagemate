import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:voyagemate/core/constants/trips.dart';


class TripProvider extends ChangeNotifier {
  List<Trip> _trips = [];

  List<Trip> get trips => _trips;
  List<Trip> get savedTrips => _trips.where((t) => t.isSaved).toList();

  Future<void> fetchTrips() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('trips')
        .get();

    _trips = snapshot.docs
        .map((doc) => Trip.fromMap(doc.data(), doc.id))
        .toList();
    notifyListeners();
  }
  List<Trip> get visitedTrips => _trips.where((t) => t.isVisited).toList();
  List<Trip> get SavedTrips => _trips.where((t) => t.isSaved).toList();


  Future<void> toggleSaved(String tripId) async {
    final index = _trips.indexWhere((t) => t.id == tripId);
    if (index != -1) {
      final currentTrip = _trips[index];
      final updatedTrip = currentTrip.copyWith(isSaved: !currentTrip.isSaved);

      _trips[index] = updatedTrip;
      notifyListeners();

      // Update in Firebase
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('trips')
            .doc(tripId)
            .update({'isSaved': updatedTrip.isSaved});
      }
    }
  }

}
