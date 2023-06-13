import 'package:flutter/material.dart';
import '../../Presentation/main_page/screen_main_page.dart';
import '../../user_registration/view/splash.dart';
import '../../app/home_screen/home.dart';
import '../../user_registration/view/change_pass_view.dart';
import '../../user_registration/view/forget_password_view.dart';
import '../../user_registration/view/login_view.dart';
import '../../user_registration/view/sign_up_view.dart';


class NavigatorClass {
  static const homeScreen = "/homeScreen";
  static const loginScreen = "/userLogin";
  static const forgetPassScreen = "/forgetPass";
  static const changeforgetPass = "/changeforgetPass";
  static const signUpScreen = "/userSignUp";
  static const otpScreen = "/otpRegister";
  static const splashScreen = "/splashScreen";
  static const mainScreen = "/bottomBarView";
  static const bookingSlotScreen = "/bookingSlotScreen";
  static const paymentScreen = "/paymentScreen";
  static const venueDetailsScreen = "/VenueDetailsScreen";
  static const myBookingsView = "/MyBookingView";
  static const paymentSuccessView = "/PaymentSuccessView";
  static const searchVenueView = "/searchVenueView";

  static Map<String, Widget Function(BuildContext)> routes() {
    Map<String, Widget Function(BuildContext)> routes = {
      
      "/userSignUp": (context) => const UserSignUpScreen(),
      "/userLogin": (context) => const UserLoginScreen(),
     "/splashScreen": (context) => const SplashScreen(),
     "/homeScreen": (context) => const HomeScreen(),
      "/forgetPass": (context) => ForgetPasswordScreen(),
      "/changeforgetPass": (context) => ChangePassView(),
     "/bottomBarView": (context) => const ScreenMainPage(),
      /*  "/bookingSlotScreen": (context) => const BookingSlotView(),
      "/paymentScreen": (context) => const ProceedPayView(),
      "/VenueDetailsScreen": (context) => const VenueDetailsView(),
      "/MyBookingView": (context) => const MyBookingsView(),
      "/PaymentSuccessView": (context) => const PaymentSuccessView(),
      "/searchVenueView": (context) => const SearchVenueView(),*/
    };

    return routes;
  }

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static Route animatedRoute({
    required dynamic route,
    double dx = 0.0,
    double dy = 1.0,
    bool fade = true,
  }) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => route,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final begin = Offset(dx, dy);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        return fade
            ? FadeTransition(
                opacity: animation,
                child: ScaleTransition(
                  scale: Tween<double>(begin: 1.0, end: 1.0).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeInOut,
                    ),
                  ),
                  child: child,
                ),
              )
            : SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
      },
    );
  }
}
