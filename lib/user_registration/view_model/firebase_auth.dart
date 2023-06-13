import 'dart:developer';

import 'package:carcareuser/user_registration/model/user_signup_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/keys.dart';
import '../../utils/routes/navigations.dart';
import '../components/snackbar.dart';
import '../model/firebase_exeptions.dart';
import '../model/user_login_model.dart';

class Authentication extends ChangeNotifier {
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

  final googleSigin = GoogleSignIn();
  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future firebaseGoogleAuth(context) async {
    final navigator = Navigator.of(context);
    try {
      final googleUser = await googleSigin.signIn();

      if (googleUser == null) {
        return;
      }
      _user = googleUser;

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      navigator.pushReplacementNamed(NavigatorClass.mainScreen);
      final sharedPref = await SharedPreferences.getInstance();
      sharedPref.setBool(GlobalKeys.userLoggedWithGoogle, true);
    } on PlatformException catch (e) {
      log(e.code);
      SnackBarWidget.snackBar(context, "No internet connection");
    } on FirebaseAuthException catch (e) {
      FirebaseExceptions.cases(e, context);
    }
    notifyListeners();
  }

  Future userSingnUp(UserSignupModel userData, BuildContext context) async {
    try {
      final credential = await auth.createUserWithEmailAndPassword(
          email: userData.email!, password: userData.password!);
      final id = credential.user!.uid;
      userData.id = id;
      print(userData.toJson());
      db.collection('user').doc(id).set(userData.toJson());
      return id;
    } on FirebaseAuthException catch (e) {
      FirebaseExceptions.cases(e, context);
      return null;
    }
  }
   Future userLogin(UserLoginModel userLoginData, BuildContext context) async {
    try {
      final credential = await auth.signInWithEmailAndPassword(
          email: userLoginData.email!, password: userLoginData.password!);
      final id = credential.user!.uid;
      return id;
    } on FirebaseAuthException catch (e) {
      FirebaseExceptions.cases(e, context);
      return null;
    }
  }

  userLoginStatus(context) async {
    final navigator = Navigator.of(context);
    final sharedPrefer = await SharedPreferences.getInstance();
    final googleSigup = sharedPrefer.getBool(GlobalKeys.userLoggedWithGoogle);
    final userLoggedin = sharedPrefer.getBool(GlobalKeys.userLoggedIN);
    final userSignedUp = sharedPrefer.getBool(GlobalKeys.userSignedUp);
    if (googleSigup == true) {
      sharedPrefer.remove(GlobalKeys.userLoggedWithGoogle);
      await firebaseGoogleLogout();
      navigator.pushNamedAndRemoveUntil(
          NavigatorClass.loginScreen, (route) => false);
    } else if (userLoggedin == true) {
      auth.signOut();
      sharedPrefer.remove(GlobalKeys.userLoggedIN);
      sharedPrefer.remove(GlobalKeys.accesToken);
      navigator.pushNamedAndRemoveUntil(
          NavigatorClass.loginScreen, (route) => false);
    } else if (userSignedUp == true) {
      auth.signOut();
      sharedPrefer.remove(GlobalKeys.userSignedUp);
      sharedPrefer.remove(GlobalKeys.accesToken);
      navigator.pushNamedAndRemoveUntil(
          NavigatorClass.loginScreen, (route) => false);
    }
  }

  firebaseGoogleLogout() async {
    await googleSigin.disconnect();
    FirebaseAuth.instance.signOut();
  }
}
