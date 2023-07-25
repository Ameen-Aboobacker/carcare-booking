import 'package:cloud_firestore/cloud_firestore.dart';

class Booking {
  dynamic id;
  String? userId;
  String? sId;
  String? package;
  String? bookedDate;
  String? date;
  String? car;
  String? status;
  String? rate; 

  Booking({
    this.id,
    this.bookedDate,
    this.userId,
    this.date,
    this.package,
    this.car,
    this.sId,
    this.status,
    this.rate,
  });

  toMap() {
    return {
      'id': id,
      'sid': sId,
      'uid': userId,
      'package': package,
      'car': car,
      'bookedDate': bookedDate,
      'date': date,
      'status': status,
    };
  }

  factory Booking.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final bookingData = snapshot.data()!;
    return Booking(
      bookedDate: bookingData['bookedDate'],
      id: bookingData['id'],
      car: bookingData['car'],
      package: bookingData['package'],
      sId: bookingData['sid'],
      status: bookingData['status'],
      date: bookingData['date'],
      userId: bookingData['uid'],
    );
  }
}
