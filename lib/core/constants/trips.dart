import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

String? getCurrentUserId() {
  final User? user = _auth.currentUser;
  return user?.uid;
}

class Trip {
  final String id;
  final String agencyName;
  final String title;
  final String description;
  final String imageUrl;
  final double rating;
  final bool isSaved;
  final bool isVisited;
  final String duration;
  final String location;

  Trip({
    required this.id,
    required this.agencyName,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.rating,
    this.isSaved = false,
    this.isVisited = false,
    required this.duration,
    required this.location,
  });

  Trip copyWith({
    String? id,
    String? agencyName,
    String? title,
    String? description,
    String? imageUrl,
    double? rating,
    bool? isSaved,
    bool? isVisited,
    String? duration,
    String? location,
  }) {
    return Trip(
      id: id ?? this.id,
      agencyName: agencyName ?? this.agencyName,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      rating: rating ?? this.rating,
      isSaved: isSaved ?? this.isSaved,
      isVisited: isVisited ?? this.isVisited,
      duration: duration ?? this.duration,
      location: location ?? this.location,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "agencyName": agencyName,
      "title": title,
      "description": description,
      "imageUrl": imageUrl,
      "rating": rating,
      "isSaved": isSaved,
      "isVisited": isVisited,
      "duration": duration,
      "location": location,
    };
  }

  factory Trip.fromMap(Map<String, dynamic> map, String id) {
    return Trip(
      id: id,
      agencyName: map["agencyName"] ?? "",
      title: map["title"] ?? "",
      description: map["description"] ?? "",
      imageUrl: map["imageUrl"] ?? "",
      rating: (map["rating"] ?? 0).toDouble(),
      isSaved: map["isSaved"] ?? false,
      isVisited: map["isVisited"] ?? false,
      duration: map["duration"] ?? "",
      location: map["location"] ?? "",
    );
  }
}



class TripDetails {
  final String id;
  final String title;
  final String location;
  final String nearLocation;
  final double price;
  final String priceUnit;
  final double rating;
  final int reviewCount;
  final String aboutDestination;
  final List<String> scheduleItems;
  final List<TripReview> reviews;
  final String heroImage;
  final List<String> galleryImages;

  TripDetails({
    required this.id,
    required this.title,
    required this.location,
    required this.nearLocation,
    required this.price,
    required this.priceUnit,
    required this.rating,
    required this.reviewCount,
    required this.aboutDestination,
    required this.scheduleItems,
    required this.reviews,
    required this.heroImage,
    required this.galleryImages,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'location': location,
      'nearLocation': nearLocation,
      'price': price,
      'priceUnit': priceUnit,
      'rating': rating,
      'reviewCount': reviewCount,
      'aboutDestination': aboutDestination,
      'scheduleItems': scheduleItems,
      'reviews': reviews.map((r) => r.toMap()).toList(),
      'heroImage': heroImage,
      'galleryImages': galleryImages,
    };
  }

  factory TripDetails.fromMap(Map<String, dynamic> map) {
    return TripDetails(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      location: map['location'] ?? '',
      nearLocation: map['nearLocation'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      priceUnit: map['priceUnit'] ?? '',
      rating: (map['rating'] ?? 0).toDouble(),
      reviewCount: map['reviewCount'] ?? 0,
      aboutDestination: map['aboutDestination'] ?? '',
      scheduleItems: List<String>.from(map['scheduleItems'] ?? []),
      reviews:
          (map['reviews'] as List<dynamic>?)
              ?.map((r) => TripReview.fromMap(r))
              .toList() ??
          [],
      heroImage: map['heroImage'] ?? '',
      galleryImages: List<String>.from(map['galleryImages'] ?? []),
    );
  }
}

class TripReview {
  final String userName;
  final double rating;
  final String comment;

  TripReview({
    required this.userName,
    required this.rating,
    required this.comment,
  });

  Map<String, dynamic> toMap() {
    return {'userName': userName, 'rating': rating, 'comment': comment};
  }

  factory TripReview.fromMap(Map<String, dynamic> map) {
    return TripReview(
      userName: map['userName'] ?? '',
      rating: (map['rating'] ?? 0).toDouble(),
      comment: map['comment'] ?? '',
    );
  }
}


