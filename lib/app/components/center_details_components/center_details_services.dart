import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carcareuser/app/view_model/services_provider.dart';

import '../../../utils/global_values.dart';
import '../../../utils/textstyles.dart';

class ServicesWidget extends StatelessWidget {
  const ServicesWidget({
    super.key,
    required this.serviceIds,
  });
  final List<String>? serviceIds;
  @override
  Widget build(BuildContext context) {
    final services = context.watch<ServicesProvider>();
    services.getServices(serviceIds!);
    return Column(
        children: services.services!
            .map(
              (service) => Padding(
                padding: const EdgeInsets.fromLTRB(8,10,8,0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(service.name!,style:AppTextStyles.textH4),
                    Text('${ValueAmount.rupees}${service.rate!}',style:AppTextStyles.textH4),
                  ],
                ),
              ),
            )
            .toList());
  }
}