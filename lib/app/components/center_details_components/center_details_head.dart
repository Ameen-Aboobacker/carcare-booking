import 'package:carcareuser/app/view_model/service_center_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/global_colors.dart';
import '../../../utils/global_values.dart';
import '../../../utils/textstyles.dart';

class CenterDetailsHeader extends StatelessWidget {
  const CenterDetailsHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final center = context.watch<ServiceCenterProvider>().serviceCenter;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(center.name ?? '', style: AppTextStyles.textH1),
            AppSizes.kHeight5,
            Text("${center.place}, ${center.district}, kerala",
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
              style: TextStyle(
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
