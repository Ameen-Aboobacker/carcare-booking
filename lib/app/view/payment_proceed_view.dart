import 'package:carcareuser/app/view_model/booking_provider.dart';
import 'package:flutter/material.dart';
import 'package:carcareuser/utils/global_values.dart';
import 'package:provider/provider.dart';
import '../components/payment_page_component/booking_details_container.dart';
import '../components/payment_page_component/booking_policy.dart';
import '../components/payment_page_component/payment_details_container.dart';

class ProceedPayView extends StatelessWidget {
  const ProceedPayView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Payment",
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
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
            showDialog(context: context, builder: (context) {
              return const Dialog(
                  child: Center(child: CircularProgressIndicator(),),
              );
            },);
            context.read<BookingProvider>().createRazorpayOrder();
           
          },
          child: const Text("Proceed to pay"),
        ),
      ),
    );
  }
}


