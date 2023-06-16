import 'package:flutter/material.dart';

import '../../../utils/global_colors.dart';
import '../../../utils/global_values.dart';

import '../../components/appbar_location.dart';
import '../../components/service_list_card_widget.dart';

class ServiceCenterScreenView extends StatelessWidget {
  const ServiceCenterScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    //final venueDataList = context.watch<VenueListViewModel>().venuDataList;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        automaticallyImplyLeading: false,
        title: const AppBarLocation(),
        actions: [
          IconButton(
            onPressed: () {
             // Navigator.pushNamed(context, NavigatorClass.searchVenueView);
            },
            splashColor: Colors.transparent,
            icon: const Icon(Icons.search, color: AppColors.black),
          ),
          // IconButton(
          //   onPressed: () {},
          //   splashColor: Colors.transparent,
          //   icon: const Icon(Icons.tune, color: AppColors.black),
          // ),
        ],
        bottom: const PreferredSize(
            preferredSize: Size.fromHeight(10), child: SizedBox()),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView.separated(
          itemCount: 10,
          separatorBuilder: (context, index) => AppSizes.kHeight20,
          itemBuilder: (context, index) {
           
            return SizedBox(
              width: double.infinity,
              height: 80,
              child: ServiceCenterListCardWidget(
                venueName: "center $index",
                imageUrl: 'assets/log1nbg.png',
                sportFacilityLendth: 2,
                venuePrice: '5000',
                district: "clt",
                venueID: '$index',
                
              ),
            );
          },
        ),
     
      ),
    );
  }
}