import 'package:carcareuser/app/Vehicle_Details/vehicle_details.dart';
import 'package:carcareuser/app/service_center/service_center.dart';
import 'package:carcareuser/app/view/profile/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:carcareuser/app/view_model/bottom_nav_view_model.dart';
import 'package:carcareuser/utils/global_colors.dart';

import 'home_screen/home.dart';

class BottomBarView extends StatelessWidget {
  BottomBarView({super.key});

  final List views = [
    const HomeScreen(),
    const VehicleDetails(),
    const ServiceCenter(),
    const UserProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    final bottomBarVieModel = Provider.of<BottomNavViewModel>(context);
    return Scaffold(
      body: views[bottomBarVieModel.bottomBarIndex],
      backgroundColor: AppColors.white,
      bottomNavigationBar: BottomNavigationBar(
        onTap: bottomBarVieModel.bottomOnChanged,
        currentIndex: bottomBarVieModel.bottomBarIndex,
        iconSize: 24,
        showSelectedLabels: false,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        backgroundColor: AppColors.appColor,
        elevation: 5,
        selectedItemColor: AppColors.white,
        unselectedItemColor: AppColors.grey,
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
              CupertinoIcons.sportscourt,
            ),
          ),
          BottomNavigationBarItem(
            label: "Centers",
            icon: Icon(
              Icons.car_repair_sharp,
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
