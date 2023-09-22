import 'package:carcareuser/app/components/service_list_card_widget.dart';
import 'package:carcareuser/app/view_model/service_center_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utils/global_colors.dart';
import '../../../utils/global_values.dart';
import '../../components/appbar_location.dart';


class ServiceCenterScreenView extends StatelessWidget {
  const ServiceCenterScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
  final venueDataList=context.watch<ServiceCenterProvider>().serviceCenterList;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          automaticallyImplyLeading: false,
          title: const AppBarLocation(),
         
          bottom: const PreferredSize(
              preferredSize: Size.fromHeight(10), child: SizedBox()),
        ),
        body: RefreshIndicator(
          onRefresh: () async{
            await Provider.of<ServiceCenterProvider>(context,listen: false).getServiceCenterList();
          },
          child:  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: ListView.separated(
                    itemCount: venueDataList.length,
                    separatorBuilder: (context, index) => AppSizes.kHeight20,
                    itemBuilder: (context, index) {
                      final venueData = venueDataList[index];
                      return SizedBox(
                        width: double.infinity,
                        height: 80,
                        child: ServiceCenterListCardWidget(
                          centerName: venueData.name?? 'Not',
                          imageUrl: 'assets/setting-transformed.png',
                          place: venueData.place ?? 'Not',
                          center: venueData,
                          district: venueData.district ?? 'Not Available',
                        ),
                      );
                    },
                  ),
                  )
          
        ),
        );
  }
}
