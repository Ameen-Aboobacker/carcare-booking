/*import 'package:carcareuser/app/view_model/booking_provider.dart';
import 'package:carcareuser/app/view_model/get_location_provider.dart';
import 'package:carcareuser/app/view_model/payment_provider.dart';
import 'package:carcareuser/app/view_model/services_provider.dart';*/
import 'package:carcareuser/app/view_model/vehicle_provider.dart';
import 'package:carcareuser/user_registrations/view_model/forget_password_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../app/view_model/booking_provider.dart';
import '../../app/view_model/bottom_nav_provider.dart';
/*import '../../app/view_model/service_center_provider.dart';*/
import '../../app/view_model/my_booking_provider.dart';
import '../../app/view_model/payment_provider.dart';
import '../../app/view_model/service_center_provider.dart';
import '../../app/view_model/services_provider.dart';
import '../../app/view_model/user_profile_provider.dart';

import '../../app/view_model/get_location_provider.dart';
import '../routes/auth_service.dart';
import '../../user_registrations/view_model/sign_up_view_model.dart';
import '../../user_registrations/view_model/user_login_view_model.dart';

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
      create: (context) => UserProfileProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => VehicleProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => LocationProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => ProceedPaymentViewModel(),
    ),
    ChangeNotifierProvider(
      create: (context) => ServiceCenterProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => ServicesProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => BookingProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
     ChangeNotifierProvider(
      create: (context) => MyBookingsViewModel(),
    ),
     //ChangeNotifierProvider(create: (context) => AppState()),
  ];
}
