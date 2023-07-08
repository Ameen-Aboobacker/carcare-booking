import 'package:carcareuser/app/view_model/booking_slot_view_model.dart';
import 'package:carcareuser/app/view_model/get_location_view_model.dart';
import 'package:carcareuser/app/view_model/services_view_model.dart';
import 'package:carcareuser/app/view_model/update_profile_view_model.dart';
import 'package:carcareuser/app/view_model/vehicle_screen.dart';
import 'package:carcareuser/user_registration/view_model/forget_password_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../app/view_model/bottom_nav_view_model.dart';
import '../../app/view_model/service_center_view_model.dart';
import '../../app/view_model/user_profile_view_model.dart';


import '../../user_registration/view_model/sign_up_view_model.dart';
import '../../user_registration/view_model/user_login_view_model.dart';

class ProviderClass {
  static List<SingleChildWidget> provider = [
  
    ChangeNotifierProvider(
      create: (context) => SignUpViewModel(),
    ),
    ChangeNotifierProvider(
      create: (context) => UserLoginViewModel(),
    ),
     ChangeNotifierProvider(
      create: (context) => ForgetPassViewModel(),
    ),
    ChangeNotifierProvider(
      create: (context) => BottomBarProvider(),
    ),
     ChangeNotifierProvider(
      create: (context) => UserProfileViewModel(),
    ),
     ChangeNotifierProvider(
      create: (context) => VehicleScreenModel(),
    ),
     ChangeNotifierProvider(
      create: (context) => GetLocationViewModel(),
    ),
     ChangeNotifierProvider(
      create: (context) => UpdateViewModel(),
    ),
      ChangeNotifierProvider(
      create: (context) => ServiceCenterProvider(),
    ),
     ChangeNotifierProvider(
      create: (context) => ServicesProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => BookingSlotViewModel(),
    ),
  ];
}
