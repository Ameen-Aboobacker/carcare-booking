import 'package:flutter/material.dart';
import '../../../user_registration/components/login_button_widget.dart';
import '../../../user_registration/components/text_form_field.dart';
import '../../../utils/global_values.dart';
import '../../view_model/vehicle_screen.dart';

class VehicleInput extends StatelessWidget {
  const VehicleInput({
    super.key,
    required this.vehicleScreenModel,
  });

  final VehicleScreenModel vehicleScreenModel;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      title: const Text(
        'ADD DETAILS',
        style: TextStyle(color: Colors.black),
        textAlign: TextAlign.center,
      ),
      children: [
        Form(
          child: Column(
            children: [
              TextFormWidget(
                controller: vehicleScreenModel.brandCtrl,
                labelText: 'Brand',
                keyType: TextInputType.name,
                textFieldIcon: Icons.car_rental,
              ),
              AppSizes.kHeight10,
              TextFormWidget(
                controller: vehicleScreenModel.modelCtrl,
                labelText: 'Model',
                keyType: TextInputType.name,
                textFieldIcon: Icons.car_rental,
              ),
              AppSizes.kHeight10,
              TextFormWidget(
                controller: vehicleScreenModel.numberCtrl,
                labelText: 'Vehicle Number',
                keyType: TextInputType.number,
                textFieldIcon: Icons.car_rental,
              ),
              AppSizes.kHeight10,
              TextFormWidget(
                controller: vehicleScreenModel.yearCtrl,
                labelText: 'year',
                keyType: TextInputType.number,
                textFieldIcon: Icons.car_rental,
              ),
              AppSizes.kHeight10,
              LoginButtonWidget(
                isDialog: true,
                onPressed:vehicleScreenModel.brandCtrl.text.isEmpty ||
                                 vehicleScreenModel.modelCtrl.text.isEmpty ||
                                  vehicleScreenModel.numberCtrl.text.isEmpty ||
                                  vehicleScreenModel.yearCtrl.text.isEmpty
                                  
                              ? null 
                :() {
                 vehicleScreenModel.addVehicle(context);
                },
                title: 'SAVE VEHICLE',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
