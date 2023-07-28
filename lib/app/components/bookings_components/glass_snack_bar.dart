import 'package:flutter/material.dart';
import '../../../utils/global_colors.dart';
import '../../../utils/global_values.dart';
import '../../../utils/textstyles.dart';
import 'glass_effect_container.dart';

class GlassSnackBar {
  static snackBar({
    required BuildContext context,
    Color color = AppColors.green,
    required String title,
    required String subtitle,
  }) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 200,
        ),
        elevation: 0,
        content: GlassEffect.glassEffect(
          context: context,
          height: 90,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.info,
                color: color,
              ),
              AppSizes.kWidth10,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.textH3,
                  ),
                  AppSizes.kHeight5,
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontWeight: FontWeight.w300,
                      color: AppColors.black,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}