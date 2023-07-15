import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../model/service_center_model.dart';
import '../../view_model/get_location_provider.dart';

class GetLocationWidget extends StatelessWidget {
  final ServiceCenter serviceCenter;
  const GetLocationWidget({
    super.key,
    required this.serviceCenter,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: OutlinedButton.icon(
        onPressed: () {
          context
              .read<LocationProvider>()
              .openMap(11.2487, 76.0229);
        },
        icon: const Icon(
          Icons.location_on,
          size: 28,
        ),
        label: const Text(
          "Get location",
          style: TextStyle(fontSize: 19),
        ),
      ),
    );
  }
}
