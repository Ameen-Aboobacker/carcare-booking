import 'package:flutter/material.dart';

import '../../../utils/global_colors.dart';
import '../../../utils/global_values.dart';


class DescriptionText extends StatelessWidget {
 final  String? description;
  const DescriptionText({
    super.key,
    required this.description,
  });



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       const  Text(
          "Description",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: AppColors.black,
          ),
        ),
        AppSizes.kHeight10,
        Text(description==null?'No description available':description!)
      ],
    );
  }
}