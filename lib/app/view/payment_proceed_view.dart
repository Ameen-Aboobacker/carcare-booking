import 'dart:developer';
import 'package:flutter/material.dart';


import 'package:carcareuser/utils/global_values.dart';
import 'package:carcareuser/utils/textstyles.dart';
import '../../utils/global_colors.dart';
import '../components/payment_page_component/booking_details_container.dart';
import '../components/payment_page_component/booking_policy.dart';
import '../components/payment_page_component/payment_details_container.dart';


class ProceedPayView extends StatelessWidget {
  const ProceedPayView({super.key});

  @override
  Widget build(BuildContext context) {
    /*final venueData = context.watch<VenueDetailsViewModel>().venueData;
    final bookingViewModel = context.watch<BookingSlotViewModel>();
    final paymentViewModel = context.read<ProceedPaymentViewModel>();
    final userDataViewModel = context.watch<UserProfileViewModel>();*/
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
     /* paymentViewModel.getVenueData(venueData);
      paymentViewModel.setBookingData(bookingViewModel);*/
    });
    log("Rebuilded");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Payment",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: const [
              AppSizes.kHeight20,
              BookingDetailsContainer(),
              AppSizes.kHeight10,
             /* Wallet(),
              AppSizes.kHeight10,*/
              PaymentDetailsContainer(),
              AppSizes.kHeight10,
               BookingPolicyWidget(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 45,
        width: double.infinity,
        margin: const EdgeInsets.all(20),
        child: ElevatedButton(
          onPressed: () {
            //paymentViewModel.getOrderModel(venueId: venueData.sId!);
          },
          child: const Text("Proceed to pay"),
        ),
      ),
    );
  }
}

class Wallet extends StatelessWidget {
  const Wallet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: AppColors.lightGrey,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
               const  Icon(
                  Icons.account_balance_wallet,
                  size: 30,
                  color: Color.fromARGB(151, 0, 181, 97),
                ),
                AppSizes.kWidth10,
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Include Wallet money!",
                      style:AppTextStyles.textH4grey
                    ),
                    Text(
                      "Wallet balance : ₹  0.0",
                      style: AppTextStyles.textH5grey,
                    ),
                  ],
                ),
              ],
            ),
          ),
        Checkbox(
                value:true,
                onChanged: (value) {
                          
                          },
              ),
        ],
      ),
    );
  }
}