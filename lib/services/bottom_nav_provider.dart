
import 'package:flutter/material.dart';

import '../Presentation/user_screens/Vehicle_Details/vehicle_details.dart';
import '../Presentation/user_screens/home_screen/home.dart';
import '../Presentation/user_screens/packages/packages.dart';
import '../Presentation/user_screens/profile/profile_screen.dart';
import '../Presentation/user_screens/service_center/service_center.dart';

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
