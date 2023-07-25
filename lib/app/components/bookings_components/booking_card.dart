import 'dart:developer';
import 'package:carcareuser/app/view_model/my_booking_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utils/global_colors.dart';
import '../../../utils/global_values.dart';
import '../../../utils/textstyles.dart';
import '../../model/booking_model.dart';

class BookingCard extends StatelessWidget {
 final Booking bookingData;
  const BookingCard({
    super.key,
    required this.bookingData,
  });

  @override
  Widget build(BuildContext context) {
   
    return Card(
        
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Column(
                children: [
                     _cardTopSide(context: context,booking:bookingData),
                     _cardBottomSide(bookingData),
                ],
              )
              
            ),
          ),
        );
   
  }

  Expanded _cardBottomSide(Booking booking) {
    return Expanded(
      flex: 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.person,
                    color: Colors.blueAccent,
                    size: 20,
                  ),
                  Text(
                    booking.car??'',
                    style: AppTextStyles.textH4,
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.add_moderator,
                    color:AppColors.appColor,
                    size: 18,
                  ),
                  AppSizes.kWidth5,
                  Text(
                    booking.package?? '',
                    style: AppTextStyles.textH5,
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                booking.status??'',
                style: AppTextStyles.textH4grey,
              ),
             Text(
                '${booking.rate}',
                style:const TextStyle(
                  color: AppColors.appColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Expanded _cardTopSide({
    required BuildContext context,
    required Booking booking,
  }) {
    return Expanded(
      flex: 4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
             
              Text(
                booking.sId??"",
                style: AppTextStyles.textH4,
              ),
            ],
          ),
          Text(
            booking.date??"",
            style: AppTextStyles.textH5,
          ),
        ],
      ),
    );
  }
}
 