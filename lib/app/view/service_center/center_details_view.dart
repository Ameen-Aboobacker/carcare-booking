import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:carcareuser/utils/global_values.dart';
import 'package:carcareuser/utils/routes/navigations.dart';

import '../../components/turf_details_components/choose_package_widget.dart';
import '../../components/turf_details_components/contact_info_widget.dart';
import '../../components/turf_details_components/description_text.dart';
import '../../components/turf_details_components/get_location_widget.dart';
import '../../components/turf_details_components/sliver_appbar_widget.dart';
import '../../components/turf_details_components/center_details_head.dart';


class CenterDetailsView extends StatelessWidget {
  const CenterDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
    // final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        physics: const ScrollPhysics(),
        slivers: [
         const  SliverAppBarWidget(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  CenterDetailsHeader(),
                  AppSizes.kHeight20,
                  ChoosePackageWidget(),
                  AppSizes.kHeight20,
                  DescriptionText(),
                  AppSizes.kHeight30,
                  CenterContactInfo(),
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
            //Navigator.pushNamed(context, NavigatorClass.bookingSlotScreen);
          },
          child: const Text("BOOK NOW"),
        ),
      ),
    );
  }
}


