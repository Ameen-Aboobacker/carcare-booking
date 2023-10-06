import 'package:carcareuser/utils/global_values.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/vehicle_model.dart';
import '../../view_model/booking_provider.dart';
import '../../view_model/user_profile_provider.dart';
import '../../view_model/vehicle_provider.dart';

class CarListWidget extends StatelessWidget {
  const CarListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final booking = context.watch<BookingProvider>();
    final userProfile = context.watch<UserProfileProvider>();
    final carData = userProfile.userProfileData!.cars;
    return Consumer<VehicleProvider>(builder: (context, vehicleScreenModel, _) {
      vehicleScreenModel.getVehicleData(carData!);

      if (carData.isEmpty || vehicleScreenModel.vehicleData == null) {
        return const SimpleDialog(
          children: [Center(child: Text('Add Vehicles '))],
        );
      } else if (vehicleScreenModel.vehicleData!.isEmpty) {
        return SimpleDialog(
          title: const Text('Your Vehicles'),
          children: [
            const Center(child: Text('Add Vehicles first ')),
            AppSizes.kHeight20,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 90),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ),
          ],
        );
      } else if (vehicleScreenModel.vehicleData!.isEmpty) {
        return const Center(child: Text('Add Vehicles '));
      }
      return SimpleDialog(
        title: const Text('Your Vehicles'),
        children: [
          Column(
            children: vehicleScreenModel.vehicleData!.map((service) {
              return RadioListTile<Vehicle>(
                title: Text(service.brand!),
                subtitle: Text(service.number!),
                value: service,
                groupValue: vehicleScreenModel.selectedVehicle,
                onChanged: (value) {
                  if (value == vehicleScreenModel.selectedVehicle) {
                    vehicleScreenModel.selectCar(null);
                  } else {
                    vehicleScreenModel.selectCar(value!);
                  }
                },
              );
            }).toList(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 90),
            child: ElevatedButton(
                onPressed: () {
                  booking.setCars(vehicleScreenModel.selectedVehicle!);
                  Navigator.of(context).pop();
                },
                child: const Text('OK')),
          ),
        ],
      );
    });
  }
}
