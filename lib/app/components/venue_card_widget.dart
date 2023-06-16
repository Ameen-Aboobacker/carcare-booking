import 'package:flutter/material.dart';

import '../../utils/global_colors.dart';
import '../../utils/global_values.dart';

class VenueCardWidget extends StatelessWidget {
  final String name;
  final bool isPackage;
  const VenueCardWidget({
    required this.name,
    super.key,
    this.isPackage=false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {},
      child: SizedBox(
        width: 150,
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _imageContainer(),
              AppSizes.kHeight10,
              _venueDetails()
            ],
          ),
        ),
      ),
    );
  }

  Widget _venueDetails() {
    return Column(
      children: [
        Center(
          child: Text(
            name,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
        AppSizes.kHeight20,
        isPackage? const Text(''): const Text('palazhi , calicut'),
      ],
    );
  }

  Container _imageContainer() {
    return Container(
      width: double.infinity,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: AppColors.lightGrey,
        image: const DecorationImage(
          image: AssetImage('assets/newlogo.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
