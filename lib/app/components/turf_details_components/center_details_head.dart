import 'package:flutter/material.dart';

import '../../../utils/global_colors.dart';
import '../../../utils/global_values.dart';
import '../../../utils/textstyles.dart';

class CenterDetailsHeader extends StatelessWidget {
  const CenterDetailsHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //final venueData = context.watch<VenueDetailsViewModel>().venueData;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('sample center', style: AppTextStyles.textH1),
            AppSizes.kHeight5,
            Text("palazhi, calicut, kerala",
                style: AppTextStyles.textH5light),
            AppSizes.kHeight10,
            // const RatingStarWidget(value: 3)
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            AppSizes.kHeight10,
            Text(
              "₹1000",
              style:  TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: AppColors.black),
            )
          ],
        )
      ],
    );
  }
}
