
import 'package:flutter/material.dart';

import '../app/Vehicle_Details/vehicle_details.dart';
import '../app/view/home_screen/home.dart';
import '../app/packages/packages.dart';
import '../app/view/profile/profile_screen.dart';
import '../app/service_center/service_center.dart';

class NavbarProvider with ChangeNotifier {
  List<NavbarItem> items = [
    NavbarItem(icon: Icons.home, label: 'Home',widget:const HomeScreen()),
    NavbarItem(icon: Icons.collections_bookmark, label: 'Vehicle info',widget: const VehicleDetails()),
    NavbarItem(icon: Icons.emoji_emotions, label: 'Packages',widget: const Packages()),
    NavbarItem(icon: Icons.emoji_emotions, label: 'Service Center',widget: const ServiceCenter()),
    NavbarItem(icon: Icons.person_pin_circle_outlined, label: 'profile', widget: const UserProfileView()),
  ];
  int _selectedIndex=0;
  int get selectedIndex=>_selectedIndex;
  set selectedIndex(int value){
    _selectedIndex=value;
  notifyListeners();
  }
}

class NavbarItem {
  String? label;
  IconData? icon;
  Widget? widget;
  NavbarItem({this.label, this.icon, this.widget});
}
