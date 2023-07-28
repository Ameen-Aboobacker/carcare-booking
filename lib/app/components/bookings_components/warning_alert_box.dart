import 'package:flutter/material.dart';
import '../../../utils/global_colors.dart';
import '../../../utils/textstyles.dart';

class AlertBoxWidget {
  static alertBox({
    required BuildContext context,
    required GestureTapCallback blockButton,
    required bool blockStatus,
    required String title,
    required String blockText,
    required String buttonText,
  }) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: const Icon(
            Icons.info_outline,
            size: 100,
            weight: 1,
            fill: 1,
            color: AppColors.lightred,
          ),
          title: Text('$blockText $title!'),
          content: Text(
            'Are you sure you want to ${blockText.toLowerCase()} the ${title.toLowerCase()}?',
            style: AppTextStyles.textH4,
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                elevation: 0,
              ),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: blockButton,
              style: ElevatedButton.styleFrom(
                backgroundColor: blockStatus ? AppColors.green : AppColors.red,
                elevation: 0,
              ),
              child: Text(buttonText),
            ),
          ],
        );
      },
    );
  }
}
