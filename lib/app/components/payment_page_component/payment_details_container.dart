import 'package:carcareuser/app/view_model/booking_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utils/global_values.dart';
import '../../../utils/textstyles.dart';
//import '../../model/venue_data_model.dart';

class PaymentDetailsContainer extends StatelessWidget {
  const PaymentDetailsContainer({
    super.key,
  });

  

  @override
  Widget build(BuildContext context) {
  final package=context.watch<BookingProvider>().selectedPackages;
    return Row(
     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Package Price :", style: AppTextStyles.textH4),
            AppSizes.kHeight5,
            Text("Payable Amount :", style: AppTextStyles.textH4),
            AppSizes.kHeight20,
            Text("Total Amount :", style: AppTextStyles.textH1),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("₹${package!.price}", style: AppTextStyles.textH4),
            AppSizes.kHeight5,
            AppSizes.kHeight5,
            Text("₹ ${package.price}", style: AppTextStyles.textH4),
            AppSizes.kHeight20,
            Text("₹ ${package.price}/-", style: AppTextStyles.textH1),
          ],
        ),
      ],
    );
  }
}
