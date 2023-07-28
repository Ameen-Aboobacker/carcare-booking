import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/global_values.dart';
import '../../view_model/services_provider.dart';

class PackagesWidget extends StatelessWidget {
  const PackagesWidget({
    super.key,
    this.centerID,
  });
  final String? centerID;
  @override
  Widget build(BuildContext context) {
    final packages = context.watch<ServicesProvider>();
    packages.getPackages(centerID!);
    if (packages.packages == null) {
      return const Center(child: CircularProgressIndicator());
    } else if (packages.packages!.isEmpty) {
      return const Text('You have no packages');
    }
    return Column(
        children: packages.packages!
            .map(
              (packages) =>  Padding(
                padding: const EdgeInsets.fromLTRB(8,10,8,0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(packages.name!),
                    Text('${ValueAmount.rupees} ${packages.price}'),
                  ],
                ),
              ),
            )
            .toList());
  }
}