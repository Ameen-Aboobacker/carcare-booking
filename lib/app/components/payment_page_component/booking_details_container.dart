import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../utils/global_colors.dart';
import '../../../utils/global_values.dart';
import '../../../utils/textstyles.dart';
import '../../view_model/booking_provider.dart';
import '../../view_model/service_center_provider.dart';


class BookingDetailsContainer extends StatelessWidget {
  const BookingDetailsContainer({super.key});

  @override
  Widget build(BuildContext context) {
   final centerData = context.watch<ServiceCenterProvider>().serviceCenter;
    final bookingData = context.watch<BookingProvider>();

    final bookedDate =
       bookingData.selectedDate;
    final package=bookingData.selectedPackages;
    final car=bookingData.selectedCar;

    return Container(
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: AppColors.lightGrey,
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${centerData.name}', style: AppTextStyles.textH1),
            _turfDetails(
                icon: Icons.abc,
                text:'${package?.name}' ),
            _turfDetails(icon: Icons.car_repair, text: car==null?'car':car.brand!),
            _turfDetails(
                icon: Icons.access_time_rounded,
                text: bookedDate!),
            _turfDetails(
                icon: Icons.payments_outlined,
                text: "₹${package?.price}"),
          ],
        ),
      ),
    );
  }

  Row _turfDetails({
    required IconData icon,
    required String text,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 15,
          color: const Color.fromARGB(150, 0, 0, 0),
        ),
        AppSizes.kWidth5,
        Text(
          text,
          style: AppTextStyles.textH5light,
        ),
      ],
    );
  }
}
