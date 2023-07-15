
import 'package:carcareuser/app/view/packages.dart';
import 'package:carcareuser/app/model/service_center_model.dart';
import 'package:carcareuser/app/view_model/booking_provider.dart';
import 'package:carcareuser/utils/global_colors.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utils/textstyles.dart';


class ChoosePackageWidget extends StatelessWidget {
  final ServiceCenter? center;
  const ChoosePackageWidget({
    super.key,
    required this.center,
  });

  @override
  Widget build(BuildContext context) {
      final booking = context.watch<BookingProvider>();
    final package = booking.selectedPackages;
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
            child: package == null
                ? Text('Choose a Package', style: AppTextStyles.textH2)
                : Text(
                    "${package.name} - ${package.price}",
                    style: AppTextStyles.textH3,
                  ),
          ),
        ),
        IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Packages(center: center),
            ));
          },
          icon: const Icon(Icons.add_moderator,
              size: 30, color: AppColors.appColor),
        ),
      ],
    );
  }
}
