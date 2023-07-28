import 'dart:developer';

import 'package:carcareuser/app/view_model/user_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/global_colors.dart';
import '../../utils/routes/navigations.dart';
import '../view_model/booking_provider.dart';
import '../view_model/payment_provider.dart';

class PaymentSuccessView extends StatelessWidget {
  const PaymentSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    final paymentViewModel = context.watch<BookingProvider>();
    log("Order id : ${paymentViewModel.orderId}");
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(
          context,
          NavigatorClass.mainScreen,
          (route) => false,
        );
      // context.read<MyBookingsVie>().getMyBookingsDatas();
        context.read<BookingProvider>().clearBookingSelection();
        context.read<UserProfileProvider>().getUserData();
        return true;
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle_outline_rounded,
                size: 80,
                color: AppColors.appColor,
              ),
              const Text(
                "Payment\n Succsessfull!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                  color: AppColors.appColor,
                ),
              ),
              Text(
                "Order id : ${paymentViewModel.orderId}",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 19,
                  color: AppColors.appColor,
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        NavigatorClass.mainScreen,
                        (route) => false,
                      );
                     // context.read<MyBookingsViewModel>().getBookings(bookingIds);
                      context
                          .read<BookingProvider>()
                          .clearBookingSelection();
                      context.read<UserProfileProvider>().getUserData();
                    },
                    style: ElevatedButton.styleFrom(elevation: 0),
                    child: const Text("Go to Home"),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
