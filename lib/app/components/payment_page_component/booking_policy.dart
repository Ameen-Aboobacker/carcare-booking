import 'package:flutter/material.dart';

import '../../../utils/global_colors.dart';
import '../../../utils/global_values.dart';
import '../../../utils/textstyles.dart';

class BookingPolicyWidget extends StatelessWidget {
  const BookingPolicyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data:
          Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        collapsedIconColor: AppColors.black,
        title: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Booking Policies",
                style: AppTextStyles.textH3,
              ),
              const Divider(
                thickness: 1.5,
                color: Colors.black,
              )
            ],
          ),
        ),
        tilePadding: const EdgeInsets.all(0),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Resceduling policy",
                style: AppTextStyles.textH3,
              ),
              AppSizes.kHeight5,
              const Text(
                  '''Rescheduling is not allowed prior to slot time.Instead of Rescheduling of a booking you are able to cancell the booking. Once cancelled, you will get your amount back, somehow , you may not be able get the same slot again.'''),
            ],
          ),
          AppSizes.kHeight10,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Cancel policy",
                style: AppTextStyles.textH3,
              ),
              AppSizes.kHeight5,
              const Text(
                  '''0-8 hrs prior to slot: Cancellations not allowed.>8 hrs prior to slot: All the booked Amount will be refunded to your wallet. You can use your wallet for your next booking and Note that you are not able to withdraw the wallet money!'''),
            ],
          ),
        ],
      ),
    );
  }
}