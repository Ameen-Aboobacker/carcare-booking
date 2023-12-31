import 'package:carcareuser/app/components/center_details_components/get_location_widget.dart';
import 'package:carcareuser/app/view/booking_slot_view.dart';
import 'package:carcareuser/app/view_model/service_center_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:carcareuser/utils/global_values.dart';
import 'package:provider/provider.dart';

import '../../components/center_details_components/center_details_packages.dart';
import '../../components/center_details_components/center_details_services.dart';
import '../../components/center_details_components/contact_info_widget.dart';
import '../../components/center_details_components/description_text.dart';
import '../../components/center_details_components/sliver_appbar_widget.dart';
import '../../components/center_details_components/center_details_head.dart';

class CenterDetailsView extends StatelessWidget {
  const CenterDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
    final centerData = context.watch<ServiceCenterProvider>().serviceCenter;
    final centerViewModel = context.watch<ServiceCenterProvider>();
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        physics: const ScrollPhysics(),
        slivers: [
          SliverAppBarWidget(
              centerData: centerData, centerViewModel: centerViewModel),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CenterDetailsHeader(),
                  AppSizes.kHeight20,
                  GetLocationWidget(serviceCenter: centerData),
                  AppSizes.kHeight20,
                  DescriptionText(description: centerData.description),
                  AppSizes.kHeight30,
                  CenterContactInfo(contact: centerData.contact),
                  AppSizes.kHeight20,
                  const Buttonswidget(),
                  AppSizes.kHeight20,
                  Consumer<ServiceCenterProvider>(
                    builder: (context, value, child) {
                      if (value.selected == 'packages') {
                        return PackagesWidget(centerID: centerData.id);
                      }
                      return ServicesWidget(serviceIds: centerData.service);
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 45,
        width: double.infinity,
        margin: const EdgeInsets.all(20),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookingSlotView(center: centerData),
                ));
          },
          child: const Text("BOOK NOW"),
        ),
      ),
    );
  }
}

class Buttonswidget extends StatelessWidget {
  const Buttonswidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final serviceCenterView = context.watch<ServiceCenterProvider>();
    return Column(
      children: [
        Row(
          children: [
            serviceCenterView.selected == 'services'
                ? ElevatedButton(
                    onPressed: () {
                      serviceCenterView.setSelected('services');
                    },
                    child: const Text('services'),
                  )
                : OutlinedButton(
                    onPressed: () {
                      serviceCenterView.setSelected('services');
                    },
                    child: const Text('services'),
                  ),
            AppSizes.kWidth30,
            serviceCenterView.selected == 'packages'
                ? ElevatedButton(
                    onPressed: () {
                      serviceCenterView.setSelected('services');
                    },
                    child: const Text('packages'),
                  )
                : OutlinedButton(
                    onPressed: () {
                      serviceCenterView.setSelected('packages');
                    },
                    child: const Text('package'),
                  )
          ],
        ),
      ],
    );
  }
}




