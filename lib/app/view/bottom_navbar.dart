import 'package:carcareuser/app/view/Vehicle_Details/vehicle_details.dart';
import 'package:carcareuser/app/view/service_center/service_center.dart';
import 'package:carcareuser/app/view/profile/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:carcareuser/app/view_model/bottom_nav_view_model.dart';
import 'package:carcareuser/utils/global_colors.dart';
import 'home_screen/home_view.dart';

class BottomBarView extends StatelessWidget {
  BottomBarView({super.key});

  final List views = [
    const HomeScreenView(),
    const VehicleDetails(),
    const ServiceCenterScreenView(),
    const UserProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    final bottomBarVieModel = Provider.of<BottomBarViewModel>(context);
    return Scaffold(
      body: views[bottomBarVieModel.newIndex],
      backgroundColor: AppColors.white,
      bottomNavigationBar: BottomNavigationBar(
        onTap: bottomBarVieModel.bottomOnChanged,
        currentIndex: bottomBarVieModel.newIndex,
        iconSize: 24,
        showSelectedLabels: true,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        backgroundColor: AppColors.appColor,
        elevation: 5,
        selectedItemColor: AppColors.white,
        unselectedItemColor: AppColors.yellow,
        items: const [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(
              Icons.home_outlined,
            ),
          ),
          BottomNavigationBarItem(
            label: "Vehicle",
            icon: Icon(
              CupertinoIcons.car_detailed,
            ),
          ),
          BottomNavigationBarItem(
            label: "Centers",
            icon: Icon(
            Icons.build_outlined,
            ),
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: Icon(
              Icons.person_outline_sharp,
            ),
          ),
        ],
      ),
    );
  }
}
