
import 'package:flutter/material.dart';

import '../../utils/global_values.dart';
import '../../utils/textstyles.dart';
import '../components/booking_slot_components/booking_slot_bottom_bar.dart';
import '../components/booking_slot_components/date_container.dart';
import '../components/booking_slot_components/time_manage_widget.dart';



class BookingSlotView extends StatelessWidget {
  const BookingSlotView({super.key});

  @override
  Widget build(BuildContext context) {
  

    return  Scaffold(
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
                const TimeManageWidget()
              ],
            ),
          ),
        ),
        bottomNavigationBar: const BookingSlotBottomBar(),
      );
  }
}
