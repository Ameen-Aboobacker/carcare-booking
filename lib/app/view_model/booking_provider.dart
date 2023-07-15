import 'dart:developer';

import 'package:carcareuser/app/model/booking_model.dart';
import 'package:carcareuser/user_registrations/components/snackbar.dart';
import 'package:carcareuser/user_registrations/view_model/firebase_services.dart';
import 'package:carcareuser/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../utils/api_status.dart';
import '../model/package_model.dart';
import '../model/vehicle_model.dart';
//import 'package:sporter_turf_booking/home/view_model/venue_details_view_model.dart';

class BookingProvider with ChangeNotifier {
  FirebaseServices firebase=FirebaseServices();
  // List<SlotAvailabilityModel> _slotAvailability = [];

  String? _selectedDate;
  final List<DateTime> _dates = [];
  String _selectedRadioButton = "";
  PackageModel? _selectedPackages;
  Vehicle? _selectedCar;

  String? get selectedDate => _selectedDate;
  List<DateTime> get dates => _dates;
  String get selectedRadioButton => _selectedRadioButton;
  PackageModel? get selectedPackages => _selectedPackages;
  Vehicle? get selectedCar => _selectedCar;

  setPackages(PackageModel package) {
    _selectedPackages = package;

    notifyListeners();
  }

  setCars(Vehicle car) {
    _selectedCar = car;

    notifyListeners();
  }




  // Date format controller ---------------

  setSelectedDate(DateTime? selectedDate) {
    if(selectedDate != null)
         {
          _selectedDate= DateFormat('d/M/y , EEEE').format(selectedDate);
         }
        else{_selectedDate= '';}
    notifyListeners();
  }

  String date=DateFormat('d/M/y').format(DateTime.now());

  // CHECK SELECTED ALL FACILITY NEEDED

  checkBookingSelection() {
    if (_selectedDate == null || _selectedPackages == null
        //||_selectedCar == null
        ) {
      return false;
    }

    return true;
  }

  checkPackage() {
    if (_selectedPackages == null) {
      return false;
    }

    return true;
  }

  clearBookingSelection() {
    _selectedCar = null;
    _selectedDate = null;
    _selectedRadioButton = "";
    _selectedPackages = null;
    notifyListeners();
  }
  
  // booking
  setBooking() {
    Booking bookingData = Booking(
      bookedDate: selectedDate,
      date: date,
      package:selectedPackages?.id,
      car:selectedCar?.id,
      sId: selectedPackages?.sid,
      userId: selectedPackages?.userid,
      status:'pending',

    );
    return bookingData;
  }

  addBooking(BuildContext context)async{
    SnackBarWidget snackbar=SnackBarWidget(context);
    final userid=AccessToken.getAccessToken();
    final booking=setBooking();
    final response=await firebase.addBooking(booking);
    if(response is Success){
      log('success');
      snackbar.snackBar(message: 'Booking Successfull/n Your BookingID :${response.response}');
    }
    if(response is Failure){
     log(response.errorResponse??'');
     snackbar.snackBar(message: "something went wrong");

    }
  }
}
