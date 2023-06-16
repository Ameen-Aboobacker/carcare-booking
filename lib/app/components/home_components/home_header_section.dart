import 'package:flutter/material.dart';


import '../../../utils/global_colors.dart';
import '../../../utils/global_values.dart';

class HomeHeaderSection extends StatelessWidget {
  const HomeHeaderSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
   
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  const [
              AppSizes.kHeight20,
              Text(
                "Hello ameen",
                style:  TextStyle(
                    color: AppColors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
              AppSizes.kHeight10,
               Text(
                "Choose your service ",
                style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                ),
              ),
            ],
          ),
        ),
       
      ],
    );
  }
}
