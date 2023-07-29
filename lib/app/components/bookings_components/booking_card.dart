import 'dart:developer';
import 'package:carcareuser/app/components/bookings_components/warning_alert_box.dart';
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
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.white,
      child: Row(
        children: [
          Row(
            children: [AppSizes.kWidth10, _turfDetailsContainer(size, context)],
          ),
          const Spacer(),
          _cardTrailing(context)
        ],
      ),
    );
  }

  Column _cardTrailing(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'serviceDate:${bookingData.bookedDate}',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: AppColors.black,
              ),
            ),
            AppSizes.kHeight10,
            Text(
              '${ValueAmount.rupees}${bookingData.package.price}',
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 15,
                color: AppColors.black,
              ),
            ),
          ],
        ),
        AppSizes.kHeight10,
        /* orderId == null
            ? const Text(
                "Invalid booking",
                style: TextStyle(
                    color: AppColors.grey,
                    fontWeight: FontWeight.w500,
                    fontSize: 12),
              )
            : refund == "processed"
                ? const Text(
                    "Refunded",
                    style: TextStyle(
                        color: AppColors.red,
                        fontWeight: FontWeight.w500,
                        fontSize: 12),
                  )
                
                    : */
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: SizedBox(
            height: 25,
            child: Text(bookingData.status,style: const TextStyle(color:Colors.grey,fontWeight: FontWeight.bold),),
          ),
        )
      ],
    );
  }

  Widget _turfDetailsContainer(Size size, BuildContext context) {
    final car = '${bookingData.car.model}-${bookingData.car.number}';
    return SizedBox(
      height: 90,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: size.width * 0.35,
            child: Text(
              '${bookingData.sId.name}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
          ),
          Row(
            children: [
              const Icon(
                Icons.location_on,
                size: 16,
                color: AppColors.appColor,
              ),
              Text(
                '${bookingData.sId.place} ${bookingData.sId.district}',
                style: AppTextStyles.textH5grey,
              ),
            ],
          ),
          Row(
            children: [
              const Icon(
                Icons.add_moderator,
                size: 16,
              ),
              Text(
                "${bookingData.package.name}",
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14,),
              ),
            ],
          ),
          Text(
            car,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
