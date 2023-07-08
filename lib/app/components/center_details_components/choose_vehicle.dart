import 'dart:developer';

import 'package:carcareuser/app/view/Vehicle_Details/vehicle_details.dart';
import 'package:carcareuser/app/view/packages.dart';
import 'package:carcareuser/app/model/service_center_model.dart';
import 'package:carcareuser/app/view_model/service_center_view_model.dart';
import 'package:carcareuser/utils/global_colors.dart';
import 'package:carcareuser/utils/global_values.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/package_model.dart';

class ChooseVehicleWidget extends StatelessWidget {
  final ServiceCenter? center;
  const ChooseVehicleWidget({
    super.key,
    required this.center,
  });

  @override
  Widget build(BuildContext context) {
   // final serviceView = context.watch<ServiceCenterViewModel>();
    return /*serviceView.selectedPackages!=null&& serviceView.selectedPackages!.sid==center!.id!
        ? SelectedPackageSectionWidget(serviceView: serviceView.selectedPackages, center: center)
        : */SizedBox(
            width: double.infinity,
            height: 50,
            child: OutlinedButton.icon(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ctx) => const VehicleDetails()));
              },
              icon: const Icon(
                Icons.add_box,
                size: 28,
                color: AppColors.appColor,
              ),
              label: const Text(
                "Choose Vehicle",
                style: TextStyle(fontSize: 19, color: AppColors.appColor),
              ),
            ),
          );
  }
}

class SelectedPackageSectionWidget extends StatelessWidget {
  const SelectedPackageSectionWidget({
    super.key,
    required this.serviceView,
    required this.center,
  });

  final PackageModel? serviceView;
  final ServiceCenter? center;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left:8,right:8,top:8,bottom: 8),
      decoration: BoxDecoration(
        color: Colors.grey,
        border: Border.all(color: AppColors.appColor),
      ),
      child: Column(
          children: [
             Text(
              '${serviceView!.name} - ₹${serviceView!.price}',
              style: const TextStyle(
                  fontSize: 19,
                  color: AppColors.appColor,
                  fontWeight: FontWeight.bold),
            ),
            AppSizes.kHeight5,
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ctx) => Packages(center: center)));
              },
              icon: const Icon(
                Icons.add_box,
                size: 20,
               
              ),
              label: const Text(
                "Change Package",
                style: TextStyle(fontSize: 14,),
              ),
            ),
          ],
        ),
    );
  }
}
