import 'package:carcareuser/app/view/bottom_navbar.dart';
import 'package:carcareuser/app/view/home_screen/home_view.dart';
import 'package:carcareuser/app/view/payment_proceed_view.dart';
import 'package:carcareuser/app/view/payment_success_view.dart';
import 'package:carcareuser/app/view/service_center/center_details_view.dart';
import 'package:flutter/material.dart';
import '../../user_registrations/view/forget_password_view.dart';
import '../../user_registrations/view/login_view.dart';
import '../../user_registrations/view/sign_up_view.dart';
import '../../user_registrations/view/splash.dart';

class NavigatorClass {
  static const homeScreen = "/homeScreen";
  static const loginScreen = "/userLogin";
  static const forgetPassScreen = "/forgetPass";
  static const signUpScreen = "/userSignUp";
  static const splashScreen = "/splashScreen";
  static const mainScreen = "/bottomBarView";
  static const packagesScreen = "/PackagesScreen";
  static const myBookingsView = "/MyBookingView";
  static const centerDetailsView = "/centerDetailsView";
  static const paymentScreen = "/paymentScreen";
   static const paymentSuccessView = "/paymentSuccess";

  static Map<String, Widget Function(BuildContext)> routes() {
    Map<String, Widget Function(BuildContext)> routes = {
      "/userSignUp": (context) => const UserSignUpScreen(),
      "/userLogin": (context) => const UserLoginScreen(),
      "/splashScreen": (context) => const SplashScreenSample(),
      "/homeScreen": (context) => const HomeScreenView(),
      "/forgetPass": (context) => ForgetPasswordScreen(),
      "/bottomBarView": (context) => BottomBarView(),
      "/centerDetailsView": (context) => const CenterDetailsView(),
      "/paymentScreen": (context) => const ProceedPayView(),
      "/paymentSuccess": (context) => const PaymentSuccessView(),
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
