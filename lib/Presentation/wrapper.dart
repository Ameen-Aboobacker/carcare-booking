
//import 'package:carcareuser/Presentation/main_page/screen_main_page.dart';
//import 'package:carcareuser/Presentation/sign_in_out.dart';
import 'package:carcareuser/user_registration/view/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const UserLoginScreen();
        }
        return const UserLoginScreen();
      },
    );
  }
}
