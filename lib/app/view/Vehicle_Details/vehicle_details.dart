import 'package:carcareuser/app/model/vehicle_model.dart';
import 'package:carcareuser/app/view_model/vehicle_screen.dart';
import 'package:carcareuser/utils/global_colors.dart';
import 'package:carcareuser/utils/textstyles.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/global_values.dart';
import '../../components/vehicle_screen_components/car_details_dialog.dart';
import '../../components/vehicle_screen_components/vehicle_input.dart';

class VehicleDetails extends StatelessWidget {
  const VehicleDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vehicleScreenModel=context.read<VehicleScreenModel>();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: const Text(
          'Your Vehicles',
          style: TextStyle(color: Colors.purple),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Consumer<VehicleScreenModel>(
          builder: (context, value, child) {
            value.getVehicleData();
            final vehicleList = value.vehicleData;
            return vehicleList == null
                ? const Center(child: CircularProgressIndicator())
                : vehicleList.isEmpty
                    ? Center(
                        child: Text('ADD YOUR VEHICLE DETAILS',
                            style: AppTextStyles.loginText))
                    : ListView.separated(
                        itemBuilder: (context, index) {
                          Vehicle car = vehicleList[index];
                          return ListTile(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return CarDetailsDialog(car: car);
                                },
                              );
                            },
                            leading: const CircleAvatar(),
                            title: Text(car.brand ?? "NO"),
                            subtitle: Text(car.brand ?? 'no'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (cntxt) {
                                          return  VehicleInput(car:car);
                                        });
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () {
                                    vehicleScreenModel.deleteCar(car.id!);
                                  },
                                  icon: const Icon(Icons.delete),
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            AppSizes.kHeight10,
                        itemCount: vehicleList.length,
                      );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.appColor,
        onPressed: () {
          showDialog(
              context: context,
              builder: (cntxt) {
                return const VehicleInput();
              });
        },
        label: const Text('Add Vehicles'),
        icon: const Icon(Icons.add_box_outlined),
      ),
    );
  }
}
