import 'package:carcareuser/utils/routes/navigations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../utils/routes/auth_service.dart';
import '../../utils/global_colors.dart';
import '../../utils/global_values.dart';



class SplashScreenSample extends StatelessWidget {
  const SplashScreenSample({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context);

    Future.delayed(const Duration(seconds: 2), () {
      if (provider.status == AuthStatus.authenticated) {
        Navigator.pushReplacementNamed(context, NavigatorClass.mainScreen);
      } else {
        Navigator.pushReplacementNamed(context, NavigatorClass.loginScreen);
      }
    });

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Container(
          padding: const EdgeInsets.only(top: 30),
          width: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/setting-transformed.png'))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                'Deal with your customers smoothly',
                style: TextStyle(color: AppColors.appColor, fontSize: 17),
                textAlign: TextAlign.center,
              ),
              AppSizes.kHeight50,
              Text('CARCARE',
                  style: GoogleFonts.lemon(
                    color: AppColors.appColor,
                    fontSize: 40,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
