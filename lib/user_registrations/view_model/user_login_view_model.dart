import 'dart:developer';
import 'package:carcareuser/utils/routes/auth_service.dart';
import 'package:carcareuser/user_registrations/model/firebase_exeptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carcareuser/user_registrations/components/snackbar.dart';
import 'package:carcareuser/user_registrations/model/user_login_model.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:carcareuser/utils/keys.dart';

import '../../utils/routes/navigations.dart';
import '../model/status.dart';

class UserLoginViewModel with ChangeNotifier {
  TextEditingController loginEmailCntrllr = TextEditingController();
  TextEditingController loginPasswordCntrllr = TextEditingController();

  UserProvider? userP=UserProvider();

  bool _isShowPassword = true;
  bool _isLoading = false;
  UserLoginModel? _userData;
  FirebaseAuthException? _loginError;
  final googleSigin = GoogleSignIn();
  GoogleSignInAccount? _user;

  bool get isShowPassword => _isShowPassword;
  bool get isLoading => _isLoading;
  UserLoginModel? get userData => _userData;
  FirebaseAuthException? get loginError => _loginError;

  setShowPassword() {
    _isShowPassword = !_isShowPassword;
    notifyListeners();
  }

  setLoading(bool loading) async {
    _isLoading = loading;
    notifyListeners();
  }
setStatus(String id)async {
  SharedPreferences status=await SharedPreferences.getInstance();
  status.setString(GlobalKeys.accesToken, id);
}
  login(BuildContext context) async {
    final c = FirebaseExceptions(context);
    final navigator = Navigator.of(context);
    setLoading(true);
    final userData = userLoginData();
    final response = await userP!.login(userData);
    print(response);
    if (response is Success) {
      setStatus(response.response!);
      setLoading(false);
      clearController();
      log('hi');
      navigator.pushNamedAndRemoveUntil(
          NavigatorClass.mainScreen, (route) => false);
    }
    if (response is Failure) {
      setLoading(false);
      FirebaseAuthException error = response.errorResponse!;
      c.cases(error);
    }

    notifyListeners();
  }

  GoogleSignInAccount get user => _user!;

  Future firebaseGoogleAuth(context) async {
    SnackBarWidget snackbar=SnackBarWidget(context);
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
      snackbar.snackBar(message:e.code);
    } on FirebaseAuthException catch (e) {
      // FirebaseExceptions.cases(e, context);
    }
    notifyListeners();
  }

  void clearController() {
    loginEmailCntrllr.clear();
    loginPasswordCntrllr.clear();
  }

  clearPassword() {
    loginPasswordCntrllr.clear();
  }

  UserLoginModel userLoginData() {
    final logindata = UserLoginModel(
      email: loginEmailCntrllr.text,
      password: loginPasswordCntrllr.text,
    );

    return logindata;
  }
}