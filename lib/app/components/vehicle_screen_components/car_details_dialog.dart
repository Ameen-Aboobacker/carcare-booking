import 'package:carcareuser/utils/global_values.dart';
import 'package:flutter/material.dart';

import '../../model/vehicle_model.dart';

class CarDetailsDialog extends StatelessWidget {
  const CarDetailsDialog({
    super.key,
    required this.car,
  });

  final Vehicle car;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      title: const Text(
        'DETAILS',
        style: TextStyle(color: Colors.black),
        textAlign: TextAlign.center,
      ),
      children: [
        Form(
          child: Column(
            children: [
              Text('BRAND : ${car.brand!.toUpperCase()}'),
              AppSizes.kHeight10,
              Text('MODEL : ${car.model!.toUpperCase()}'),
              AppSizes.kHeight10,
              Text('REG NUMBER : ${car.number!.toUpperCase()}'),
              AppSizes.kHeight10,
              Text('YEAR : ${car.year!.toUpperCase()}'),
              AppSizes.kHeight10,
            ],
          ),
        ),
      ],
    );
  }
}
