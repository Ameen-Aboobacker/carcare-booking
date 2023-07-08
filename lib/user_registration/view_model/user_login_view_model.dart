import 'dart:developer';

import 'package:carcareuser/app/view_model/user_profile_view_model.dart';
import 'package:carcareuser/utils/session_controller.dart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carcareuser/user_registration/components/snackbar.dart';
import 'package:carcareuser/user_registration/model/user_login_model.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:carcareuser/utils/keys.dart';

import '../../utils/constants.dart';
import '../../utils/routes/navigations.dart';
import '../model/firebase_exeptions.dart';

class UserLoginViewModel with ChangeNotifier {
  TextEditingController loginEmailCntrllr = TextEditingController();
  TextEditingController loginPasswordCntrllr = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
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

  acess() async {
    final a = await AccessToken.getAccessToken();
    final s = await SharedPreferences.getInstance();
    log(s.getString(GlobalKeys.currentUser).toString());
    print('token a :$a');
  }

  setLoading(bool loading) async {
    _isLoading = loading;
    notifyListeners();
  }

  Future<UserLoginModel?> setUserData(UserLoginModel userData) async {
    _userData = userData;
    return _userData;
  }

  setLoginError(FirebaseAuthException loginError, context) async {
    _loginError = loginError;
    return errorResonses(_loginError!, context);
  }

  login(BuildContext context) async {
    final navigator = Navigator.of(context);
    setLoading(true);
    final userData = userLoginData();
    try {
      auth
          .signInWithEmailAndPassword(
        email: userData.email!,
        password: userData.password!,
      )
          .then((value) {
        setLoginStatus(value.user!.uid, value.user!);
        context.read<UserProfileViewModel>().getUserProfileData();

        navigator.pushNamedAndRemoveUntil(
            NavigatorClass.mainScreen, (route) => false);
        setLoading(false);
        notifyListeners();
      }).onError<FirebaseAuthException>((error, stackTrace) {
        FirebaseExceptions.cases(error, context);

        setLoading(false);
      });
    } on FirebaseAuthException catch (e) {
      setLoading(false);
      SnackBarWidget.snackBar(context, e.code);
    }
  }

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
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) async {
        navigator.pushReplacementNamed(NavigatorClass.mainScreen);
        final sharedPref = await SharedPreferences.getInstance();
        sharedPref.setBool(GlobalKeys.userLoggedWithGoogle, true);
        sharedPref.setString(GlobalKeys.accesToken, value.user!.uid);
        notifyListeners();
      });
    } on PlatformException catch (e) {
      log(e.code);
      SnackBarWidget.snackBar(context, e.code);
    } on FirebaseAuthException catch (e) {
      FirebaseExceptions.cases(e, context);
    }
    notifyListeners();
  }

  clearController() {
    loginEmailCntrllr.clear();
    loginPasswordCntrllr.clear();
  }

  clearPassword() {
    loginPasswordCntrllr.clear();
  }

  setLoginStatus(String accessToken, User user) async {
    final status = await SharedPreferences.getInstance();
    status.setBool(GlobalKeys.userLoggedIN, true);
    status.setString(GlobalKeys.accesToken, accessToken);
    status.setString(GlobalKeys.currentUser, user.toString());
  }

  UserLoginModel userLoginData() {
    final logindata = UserLoginModel(
      email: loginEmailCntrllr.text,
      password: loginPasswordCntrllr.text,
    );

    return logindata;
  }

  errorResonses(FirebaseAuthException loginError, BuildContext context) {
    final statusCode = loginError.code;
    return SnackBarWidget.snackBar(context, statusCode.toString());
  }
}
