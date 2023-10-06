import 'package:carcareuser/app/view_model/user_profile_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/global_colors.dart';
import '../../../utils/global_values.dart';
import '../../../utils/textstyles.dart';
import '../../components/vehicle_screen_components/vehicle_input.dart';
import '../../model/vehicle_model.dart';
import '../../view_model/vehicle_provider.dart';

class VehicleDetails extends StatelessWidget {
  const VehicleDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  
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
      body: SafeArea(child: Consumer<VehicleProvider>(
        builder: (context, value, child) {
          final user = context.watch<UserProfileProvider>();
          final userdata = user.userProfileData;
          final carIds = userdata?.cars;
          if (carIds == null) {
            return Center(
                child: Text('ADD YOUR VEHICLE DETAILS',
                    style: AppTextStyles.loginText));
          }
          value.getVehicleData(carIds);
          if (value.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (value.vehicleData == null) {
            return const Center(child: CircularProgressIndicator());
          } else if (value.vehicleData!.isEmpty) {
            return Center(
                child: Text('ADD YOUR VEHICLE DETAILS',
                    style: AppTextStyles.loginText));
          }
          return ListView.separated(
            itemBuilder: (context, index) {
              Vehicle car = value.vehicleData![index];
              return Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: AppColors.appColor,
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(20)),
                child: ListTile(
                  leading: CircleAvatar(child:Text('${index+1}')),
                  title: Text(car.brand ?? "NO",style: TextStyle(color: Colors.white),),
                  subtitle: Text(car.number ?? 'no',style: TextStyle(color: Colors.white),),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (cntxt) {
                                return VehicleInput(car: car);
                              });
                        },
                        icon: const Icon(Icons.edit,color: Colors.white,),
                      ),
                      IconButton(
                        onPressed: () {
                          value.deleteCar(car.id!);
                          // user.getUserData();
                        },
                        icon: const Icon(Icons.delete,color: Colors.white),
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => AppSizes.kHeight10,
            itemCount: value.vehicleData!.length,
          );
        },
      )),
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
