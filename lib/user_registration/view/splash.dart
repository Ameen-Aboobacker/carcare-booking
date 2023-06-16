import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:carcareuser/utils/global_values.dart';
import 'package:carcareuser/utils/session_controller.dart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carcareuser/user_registration/view/login_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app/view/bottom_navbar.dart';
import '../../utils/global_colors.dart';
import '../../utils/keys.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: loginStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return AnimatedSplashScreen(
            splashIconSize: double.infinity,
            splash: Padding(
              padding: const EdgeInsets.all(50.0),
              child: Container(
                padding: const EdgeInsets.only(top: 30),
                width: double.infinity,
                decoration: const BoxDecoration(image: DecorationImage(image:  AssetImage('assets/setting-transformed.png'))),
                child: Column(
mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('CARCARE',style:GoogleFonts.lemon(color: AppColors.appColor,fontSize: 30,)),
                    AppSizes.kHeight50,
                    AppSizes.kHeight50,
                     Text('CARCARE',style:GoogleFonts.lemon(color: AppColors.appColor,fontSize: 30,)),
                  ],
                ),
              ),
            ),
            nextScreen: snapshot.data!,
          );
        },
      ),
    );
  }
}

Future<Widget> loginStatus() async {
  final FirebaseAuth auth=FirebaseAuth.instance;
  final status = await SharedPreferences.getInstance();
  final id=status.getString(GlobalKeys.accesToken);    
      final user=auth.currentUser;
  if (user!=null) {
    status.setString(GlobalKeys.accesToken,user.uid);
    return  BottomBarView();
  } else if(id!=null) {
    print(id);
    return  BottomBarView();
}
else{
  return const UserLoginScreen();
}
}