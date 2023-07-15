import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:carcareuser/app/model/service_center_model.dart';
import '../../utils/global_values.dart';
import '../../utils/textstyles.dart';
import '../components/booking_slot_components/booking_slot_bottom_bar.dart';
import '../components/booking_slot_components/date_container.dart';
import '../components/booking_slot_components/choose_package_widget.dart';
import '../components/booking_slot_components/choose_vehicle.dart';

class BookingSlotView extends StatelessWidget {
  const BookingSlotView({super.key, this.center});
  final ServiceCenter? center;
  @override
  Widget build(BuildContext context) {
    log(center.toString());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Booking",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSizes.kHeight20,
              Text("Select Date", style: AppTextStyles.textH2),
              AppSizes.kHeight20,
              const DateContainerWidget(),
              AppSizes.kHeight30,
              Text("Select Package", style: AppTextStyles.textH2),
              AppSizes.kHeight20,
              ChoosePackageWidget(center: center),
              AppSizes.kHeight30,
              Text("Select Vehicle", style: AppTextStyles.textH2),
              AppSizes.kHeight20,
              ChooseVehicleWidget(center: center),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BookingSlotBottomBar(),
    );
  }
}
