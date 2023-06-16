
import 'package:carcareuser/app/view_model/vehicle_screen.dart';
import 'package:carcareuser/utils/global_colors.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/global_values.dart';
import '../../components/vehicle_screen_components/vehicle_input.dart';

class VehicleDetails extends StatefulWidget {
  const VehicleDetails({Key? key}) : super(key: key);

  @override
  State<VehicleDetails> createState() => _VehicleDetailsState();
}

class _VehicleDetailsState extends State<VehicleDetails> {
  @override
  Widget build(BuildContext context) {
    final vehicleScreenModel = context.watch<VehicleScreenModel>();

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
          child: vehicleScreenModel.car.isEmpty
              ? const Center(
                  child: Text('nodata'),
                )
              : ListView.separated(
                  itemBuilder: (context, index) {
                    Map car = vehicleScreenModel.car[index].toMap();
                    return ListTile(
                      leading: const CircleAvatar(),
                      title: Text(car['Model']),
                      subtitle: Text(car['Brand']),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              vehicleScreenModel.car.clear();
                            },
                            icon: const Icon(Icons.delete),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => AppSizes.kHeight10,
                  itemCount: vehicleScreenModel.car.length,
                )),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.appColor,
        onPressed: () {
          showDialog(
              context: context,
              builder: (cntxt) {
                return VehicleInput(vehicleScreenModel: vehicleScreenModel);
              });
        },
        label: const Text('Add Vehicles'),
        icon: const Icon(Icons.add_box_outlined),
      ),
    );
  }
}


