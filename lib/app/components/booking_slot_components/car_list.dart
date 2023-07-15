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
    final userProfile=context.watch<UserProfileProvider>();
userProfile.getUserProfileData();
final carData=userProfile.userProfileData!.cars;
    return Consumer<VehicleProvider>(
        builder: (context, vehicleScreenModel, _) {
          vehicleScreenModel.getVehicleData(carData!);
      return AlertDialog(
        title: const Text('Your Vehicles'),
        content: Column(
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
        actions: [
          ElevatedButton(onPressed: () {
            booking.setCars(vehicleScreenModel.selectedVehicle!);
            Navigator.of(context).pop();
          }, child: const Text('OK')),
        ],
      );
    });
  }
}
