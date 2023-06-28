import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/global_colors.dart';
import '../../../utils/global_values.dart';
import '../../../utils/textstyles.dart';

class TimeManageWidget extends StatelessWidget {
  const TimeManageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // final venueViewModel = context.watch<VenueDetailsViewModel>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Text("From", style: AppTextStyles.textH2),
            AppSizes.kHeight20,
          ],
        ),
        Container(
          height: 90,
          width: 1.5,
          color: AppColors.black,
        ),
        Column(
          children: [
            Text("To", style: AppTextStyles.textH2),
            AppSizes.kHeight20,
           _timeContainer(context),
          ],
        )
      ],
    );
  }

  Widget _timeContainer(
    BuildContext context, {
   
    bool isFromSlot=true,
  }) {
    return GestureDetector(
      onTap: () async {
        if (isFromSlot) {
          _showSlotsBottomSheet(context, true);
        } else if (!isFromSlot) {
          _showSlotsBottomSheet(context, false);
        }
      },
      child: Container(
        width: 150,
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: AppColors.lightGrey,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("chonsem time", style: AppTextStyles.textH4),
                AppSizes.kWidth5,
                const Icon(
                  Icons.arrow_drop_down_circle_outlined,
                  size: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showSlotsBottomSheet(BuildContext context, bool isFromSlot) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
      
        return Container(
          margin: const EdgeInsets.all(20),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              mainAxisExtent: 45,
            ),
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (BuildContext context, int slotIndex) {
              return InkWell(
                onTap: () {
                
                },
                child: Material(
                  elevation: 1,
                  borderRadius: BorderRadius.circular(7),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: Colors.black),
                    child: const Center(
                      child: Text(
                        'time',
                        style: TextStyle(
                          color: AppColors.lightGrey,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
