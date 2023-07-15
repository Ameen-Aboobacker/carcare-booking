import 'package:carcareuser/app/model/service_center_model.dart';
import 'package:carcareuser/app/view_model/booking_provider.dart';
import 'package:carcareuser/utils/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utils/textstyles.dart';
import 'car_list.dart';

class ChooseVehicleWidget extends StatelessWidget {
  final ServiceCenter? center;
  const ChooseVehicleWidget({
    super.key,
    required this.center,
  });

  @override
  Widget build(BuildContext context) {
    final booking = context.watch<BookingProvider>();
      final car=booking.selectedCar;
    //log(serviceView.selectedPackages.toString());
    final size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        Container(
          height: size.height * 0.07,
          width: size.width,
          color: AppColors.appColorlight,
          child: Padding(
            padding: const EdgeInsets.only(left: 30, top: 20),
            child: car == null
                ? Text('Pick a date', style: AppTextStyles.textH2)
                : Text(
                    "${car.brand} - ${car.number}",
                    style: AppTextStyles.textH3,
                  ),
          ),
        ),
        IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => const CarListWidget(),
            );
          },
          icon:
              const Icon(Icons.add_circle, size: 30, color: AppColors.appColor),
        ),
      ],
    );
  }
}

