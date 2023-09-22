import 'dart:convert';
import 'dart:developer';

import 'package:carcareuser/app/view_model/booking_provider.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../utils/razorpay.dart';


class ProceedPaymentViewModel with ChangeNotifier {
  final _razorpay = Razorpay();
  String? amount;
  String? paymentId;
  String? _orderId;
  String? signature;
  String? generatedId;
  String? get orderId=>_orderId;
  setAmount(BookingProvider booking){
    amount =booking.selectedPackages?.price;
  }
  Future<void> createRazorpayOrder() async {
    var keyId = 'rzp_test_jsMG68GfTa87zf';
    var keySecret = 'Ug9UXv9AXx1kSxzXmX7feyWW';

    var instance = RazorpayId(keyId, keySecret);

    var orderData = {
      'amount': amount,
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

    final options = {
      'key': 'rzp_test_jsMG68GfTa87zf',
      'amount': '5000',
      'order_id': generatedId,
      'name': 'ameen',
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
    _orderId = response.orderId;
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

  void getProceedPayment() {
    log('Payment successful');
  }
}