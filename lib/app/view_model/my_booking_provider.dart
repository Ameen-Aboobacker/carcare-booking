import 'package:carcareuser/app/model/service_center_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../model/booking_model.dart';
import '../model/package_model.dart';
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
    final querySnapshot = await bookingsCollection
        .where(FieldPath.documentId, whereIn: bookingIds)
        .where('status', isEqualTo: 'pending')
        .get();

    final bookings = querySnapshot.docs.map((doc) {
      final booking = Booking.fromSnapshot(doc);
      return booking;
    }).toList();
    count=bookings.length;
    await fetchBookingDetails(bookings);
    _booking = bookings;
    notifyListeners();
  }

  fetchBookingDetails(List<Booking> bookings) async {
    final firestore = FirebaseFirestore.instance;
    final carcollection = firestore.collection('cars');
    final packagecollection = firestore.collection('packages');
    final centercollection = firestore.collection('service center');

    for (var booking in bookings) {
      final cardoc = await carcollection.doc(booking.car).get();
      booking.car = Vehicle.fromSnapshot(cardoc);
      final packdoc = await packagecollection.doc(booking.package).get();
      booking.package = PackageModel.fromDocumentSnapshot(packdoc);
      final servicedoc = await centercollection.doc(booking.sId).get();
      booking.sId = ServiceCenter.fromSnapshot(servicedoc);
    }
  }

  setBookingLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
