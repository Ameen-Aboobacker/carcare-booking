import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/global_colors.dart';
import '../../utils/global_values.dart';

class AppBarLocation extends StatelessWidget {
  const AppBarLocation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
   // final locationViewModel = context.watch<GetLocationViewModel>();
    //return Consumer<GetLocationViewModel>(
     // builder: (context, value, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
             const Icon(Icons.location_on, color: AppColors.black),
            AppSizes.kWidth10,
          /*  value.currentAddress == null
                ? Container(
                    height: 15,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: AppColors.lightGrey,
                    ),
                  )
                : value.currentAddress!.country!.isEmpty
                    ?  Text(
                        "No location picked",
                        style: TextStyle(
                            color: AppColors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      )
                    : */ Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:const [
                           Text(
                            'Location',
                            style:  TextStyle(
                                color: AppColors.black,
                                fontSize: 19,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "Location",
                            style: TextStyle(
                              color: AppColors.black,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      )
          ],
        );
      }
    
}
