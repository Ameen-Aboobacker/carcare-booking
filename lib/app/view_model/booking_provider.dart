import 'dart:convert';
import 'dart:developer';

import 'package:carcareuser/app/model/booking_model.dart';
import 'package:carcareuser/user_registrations/components/snackbar.dart';
import 'package:carcareuser/user_registrations/view_model/firebase_services.dart';
import 'package:carcareuser/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../utils/api_status.dart';
import '../../utils/razorpay.dart';
import '../../utils/routes/navigations.dart';
import '../model/package_model.dart';
import '../model/vehicle_model.dart';
//import 'package:sporter_turf_booking/home/view_model/venue_details_view_model.dart';

class BookingProvider with ChangeNotifier {
  FirebaseServices firebase = FirebaseServices();

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
   final _razorpay = Razorpay();

  String? paymentId;
  String? orderId;
  String? signature;
  String? generatedId;

  setPackages(PackageModel package) {
    _selectedPackages = package;

    notifyListeners();
  }

  setCars(Vehicle car) {
    _selectedCar = car;

    notifyListeners();
  }

 
 

  Future<void> createRazorpayOrder() async {
     int price=int.parse(selectedPackages!.price!)*100;
    var keyId = 'rzp_test_jsMG68GfTa87zf';
    var keySecret = 'Ug9UXv9AXx1kSxzXmX7feyWW';

    var instance = RazorpayId(keyId, keySecret);

    var orderData = {
      'amount': price,
      'currency': 'INR',
      'receipt': 'receipt#1',
      'notes': {
        'key1': 'value3',
        'key2': 'value2',
      },
    };

    var response = await instance.createOrder(orderData);

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      generatedId = responseData['id'];
      log('generatedId: $generatedId');
      openPayment();
    } else {
      log('Error creating order: ${response.statusCode}');
    }
  }

  void openPayment() async {
    if (generatedId == null) {
      log('Generated ID is null. Please call createRazorpayOrder() first.');
      return;
    }
    int price=int.parse(selectedPackages!.price!)*100;
    log(price.toString());
    final options = {
      'key': 'rzp_test_jsMG68GfTa87zf',
      'amount': price,
      'order_id': generatedId,
      'name': 'carcare',
      'description': 'car booking',
      'timeout': 60,
      'prefill': {
        'contact': '8606044404',
        'email': 'kaameen95@gmail.com',
      },
      'themeColor': '#7F00FF',
    };

    try {
      _razorpay.open(options);
      log('Payment window opened');
      razorPayPayment();
    } catch (e) {
      log(e.toString());
    }
  }

  void razorPayPayment() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    paymentId = response.paymentId;
    orderId = response.orderId;
    signature = response.signature;
    log('orderId: $orderId, signature: $signature');
     getProceedPayment();
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    log(response.toString());
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

   getProceedPayment() async {
      final booking = setBooking();
    final response = await firebase.addBooking(booking);
    if (response is Success) {
      NavigatorClass.navigatorKey.currentState?.pushNamedAndRemoveUntil(
          NavigatorClass.paymentSuccessView, (route) => false);

      log("Success");
      log('get:${response.response.toString()}');
    }
    if (response is Failure) {
      log("Error");
    }
  }

  // Date format controller ---------------

  setSelectedDate(DateTime? selectedDate) {
    if (selectedDate != null) {
      _selectedDate = DateFormat('d/M/y , EEEE').format(selectedDate);
    } else {
      _selectedDate = '';
    }
    notifyListeners();
  }

  String date = DateFormat('d/M/y').format(DateTime.now());

  // CHECK SELECTED ALL FACILITY NEEDED

  checkBookingSelection() {
    if (_selectedDate == null ||
        _selectedPackages == null ||
        _selectedCar == null) {
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
      package: selectedPackages?.id,
      car: selectedCar?.id,
      sId: selectedPackages?.sid,
      userId: selectedPackages?.userid,
      status: 'pending',
    );
    return bookingData;
  }

  addBooking() async {
  
  }
}
