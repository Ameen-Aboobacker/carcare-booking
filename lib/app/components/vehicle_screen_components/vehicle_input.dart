import 'package:carcareuser/app/model/vehicle_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../user_registrations/components/login_button_widget.dart';
import '../../../user_registrations/components/text_form_field.dart';
import '../../../utils/global_values.dart';
import '../../view_model/user_profile_provider.dart';
import '../../view_model/vehicle_provider.dart';

class VehicleInput extends StatelessWidget {
  final Vehicle? car;

  const VehicleInput({
    super.key,
    this.car,
  });

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> inputkey= GlobalKey<FormState>();
    final vehicleScreenModel = context.read<VehicleProvider>();
        final userprofile = context.read<UserProfileProvider>();
    vehicleScreenModel.brandCtrl.text = car?.brand ?? '';
    vehicleScreenModel.modelCtrl.text = car?.model ?? '';
    vehicleScreenModel.yearCtrl.text = car?.year ?? '';
    vehicleScreenModel.numberCtrl.text = car?.number ?? '';
    return SimpleDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      title: Text(
        car == null ? 'ADD DETAILS' : 'EDIT DETAILS',
        style: const TextStyle(color: Colors.black),
        textAlign: TextAlign.center,
      ),
      children: [
        Form(
          key: inputkey,
          child: Column(
            children: [
              TextFormWidget(
                isvehicle: true,
                controller: vehicleScreenModel.brandCtrl,
                keyType: TextInputType.name,
                textFieldIcon: Icons.car_rental,
                labelText: 'Brand',
              ),
              AppSizes.kHeight10,
              TextFormWidget(
                isvehicle: true,
                controller: vehicleScreenModel.modelCtrl,
                labelText: 'Model',
                keyType: TextInputType.name,
                textFieldIcon: Icons.car_rental,
              ),
              AppSizes.kHeight10,
              TextFormWidget(
                isvehicle: true,
                isvehiclenumber: true,
                controller: vehicleScreenModel.numberCtrl,
                labelText: 'Vehicle Number',
                keyType: TextInputType.text,
                textFieldIcon: Icons.car_rental,
              ),
              AppSizes.kHeight10,
              TextFormWidget(
                isvehicle: true,
                isyear:true,
                controller: vehicleScreenModel.yearCtrl,
                labelText: 'year',
                keyType: TextInputType.number,
                textFieldIcon: Icons.car_rental,
              ),
              AppSizes.kHeight10,
              Padding(
                padding: const EdgeInsets.only(left:40,right: 40),
                child: LoginButtonWidget(
                  isDialog: true,
                  onPressed: (){
                    if(inputkey.currentState!.validate()){
                       if(car == null)
                           {
                              vehicleScreenModel.addVehicle(context,userprofile);
                              userprofile.getUserData();
                            }
                            else
                            {
                              vehicleScreenModel.update(context, car!.id!,userprofile);
                              userprofile.getUserData();
                            }
                    }
                  },
                  title: car == null ? 'SAVE VEHICLE' : 'UPDATE',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
