import 'package:carcareuser/utils/global_colors.dart';
import 'package:flutter/material.dart';

import '../../../utils/routes/navigations.dart';

class ChoosePackageWidget extends StatelessWidget {
  const ChoosePackageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: OutlinedButton.icon(
        onPressed: () {},
        icon: const Icon(
          Icons.add_box,
          size: 28,
          color: AppColors.appColor,
        ),
        label: const Text(
          "Choose Package",
          style: TextStyle(fontSize: 19, color: AppColors.appColor),
        ),
      ),
    );
  }
}
