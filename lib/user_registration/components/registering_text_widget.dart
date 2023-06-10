import 'package:flutter/material.dart';

import '../../utils/global_colors.dart';

class RegisteringText extends StatelessWidget {
  const RegisteringText({
    super.key,
    required this.onTap,
    required this.leftText,
    required this.rightText,
  });

  final GestureTapCallback? onTap;
  final String leftText;
  final String rightText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          leftText,
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.black),
        ),
        GestureDetector(
          onTap: onTap,
          child: SizedBox(
            height: 20,
            child: Text(
              rightText,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppColors.kButtonColor,
              ),
            ),
          ),
        )
      ],
    );
  }
}
