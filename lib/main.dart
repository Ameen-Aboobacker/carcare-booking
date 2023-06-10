import 'package:carcareuser/utils/providers/provider_classes.dart';
import 'package:carcareuser/utils/routes/navigations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Presentation/splash.dart';
import 'utils/global_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: ProviderClass.provider,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.scaffoldColor,
          elevatedButtonTheme: const ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(AppColors.kButtonColor),
            ),
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.white,
            iconTheme: IconThemeData(color: AppColors.black),
            titleTextStyle: TextStyle(
              color: AppColors.black,
              fontSize: 21,
              fontWeight: FontWeight.w600,
            ),
            elevation: 0,
          ),
        ),
        routes: NavigatorClass.routes(),
        initialRoute: NavigatorClass.splashScreen,
        navigatorKey: NavigatorClass.navigatorKey,
      ),
    );
  }
}
