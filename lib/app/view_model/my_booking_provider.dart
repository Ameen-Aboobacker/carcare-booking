import 'dart:developer';

import 'package:carcareuser/app/model/service_center_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/booking_model.dart';
import '../model/package_model.dart';
import '../model/user_profile_data_modle.dart';
import '../model/vehicle_model.dart';

class MyBookingsViewModel extends ChangeNotifier {
  int count = 0;
  List<Booking>? _booking;
  List<Booking>? get booking => _booking;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future getBookings(List<String> bookingIds) async {
    final bookingsCollection =
        FirebaseFirestore.instance.collection('bookings');
    final querySnapshot =
        await bookingsCollection.where('id', whereIn: bookingIds).get();

   final bookings =  querySnapshot.docs.map((doc){
      final booking = Booking.fromSnapshot(doc);
      return booking;
    }).toList();
    
     await fetchBookingDetails(bookings);
    _booking = bookings;
    notifyListeners();
  }

   Future fetchBookingDetails(List <Booking> bookings) async {
    final firestore = FirebaseFirestore.instance;

      // Fetch Car details
     for (var booking in bookings) {
        final carSnapshot =
          await firestore.collection('cars').doc(booking.car).get();
      if (carSnapshot.exists) {
        booking.car = Vehicle.fromSnapshot(carSnapshot)
            .model;
      }

      // Fetch Center details
      final centerSnapshot =
          await firestore.collection('service center').doc(booking.sId).get();
      if (centerSnapshot.exists) {
        booking.sId = ServiceCenter.fromSnapshot(centerSnapshot)
            .name;
      }

      // Fetch User details
      final userSnapshot =
          await firestore.collection('users').doc(booking.userId).get();
      if (userSnapshot.exists) {
        booking.userId = UserProfileDataModel.fromSnapshot(userSnapshot)
            .name;
      }

      // Fetch Package details
      final packageSnapshot =
          await firestore.collection('packages').doc(booking.package).get();
      if (packageSnapshot.exists) {
        booking.package =
            PackageModel.fromDocumentSnapshot(packageSnapshot).name;
        booking.rate = PackageModel.fromDocumentSnapshot(packageSnapshot)
            .price;
      }
     }
    notifyListeners();
  }

  setBookingLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
