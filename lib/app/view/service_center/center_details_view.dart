import 'package:carcareuser/app/view/booking_slot_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:carcareuser/utils/global_values.dart';
import 'package:provider/provider.dart';

import '../../components/turf_details_components/choose_package_widget.dart';
import '../../components/turf_details_components/contact_info_widget.dart';
import '../../components/turf_details_components/description_text.dart';
import '../../components/turf_details_components/sliver_appbar_widget.dart';
import '../../components/turf_details_components/center_details_head.dart';
import '../../view_model/center_list_view_model.dart';

class CenterDetailsView extends StatelessWidget {
  const CenterDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
      final centerData = context.watch<CenterDetailsViewModel>().serviceCenter;
    final centerViewModel = context.watch<CenterDetailsViewModel>();
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        physics: const ScrollPhysics(),
        slivers: [
           SliverAppBarWidget(
            centerData :centerData ,
            centerViewModel:centerViewModel
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CenterDetailsHeader()
                      ,
                  AppSizes.kHeight20,
                  ChoosePackageWidget(centerid: centerData.id),
                  AppSizes.kHeight20,
                  DescriptionText(description: centerData.description),
                  AppSizes.kHeight30,
                  CenterContactInfo(contact:centerData.contact),
                  AppSizes.kHeight40,
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
                  builder: (context) => const BookingSlotView(),
                ));
          },
          child: const Text("BOOK NOW"),
        ),
      ),
    );
  }
}
