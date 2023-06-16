import 'package:flutter/material.dart';
import 'package:carcareuser/utils/global_colors.dart';

class RatingStarWidget extends StatelessWidget {
  final int value;
  final double size;
  const RatingStarWidget({super.key, this.value = 0,this.size = 17});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        5,
        (index) {
          return index < value
              ?  Icon(Icons.star, color: Colors.amber, size: size)
              :  Icon(Icons.star, color: AppColors.grey, size: size);
        },
      ),
    );
  }
}

class HomeComponents {
  static Widget viewAllText({
    required String lText,
    VoidCallback? onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            lText,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 17,
            ),
          ),
          TextButton(
            onPressed: onPressed,
            style: const ButtonStyle(
              visualDensity: VisualDensity.compact,
            ),
            child: const Text("View all"),
          ),
        ],
      ),
    );
  }
}
