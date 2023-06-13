
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carcareuser/user_registration/components/snackbar.dart';
import 'package:carcareuser/user_registration/model/user_login_model.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:carcareuser/utils/keys.dart';

import '../../utils/routes/navigations.dart';
import 'firebase_auth.dart';

class UserLoginViewModel with ChangeNotifier {
  TextEditingController loginEmailCntrllr = TextEditingController();
  TextEditingController loginPasswordCntrllr = TextEditingController();

  bool _isShowPassword = true;
  bool _isLoading = false;
  UserLoginModel? _userData;
  FirebaseAuthException? _loginError;

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

  Future<UserLoginModel?> setUserData(UserLoginModel userData) async {
    _userData = userData;
    return _userData;
  }

  setLoginError(FirebaseAuthException loginError, context) async {
    _loginError = loginError;
    return errorResonses(_loginError!, context);
  }

  getLoginStatus(BuildContext context) async {
    final navigator = Navigator.of(context);
    setLoading(true);
   
    final response=await Authentication().userLogin(userDataBody(),context);
    if(response!=null){
      print(response);
      setLoginStatus(response);
      clearController();
      navigator.pushReplacementNamed(NavigatorClass.mainScreen);
    }
    
    setLoading(false);
  }

  clearController() {
    loginEmailCntrllr.clear();
    loginPasswordCntrllr.clear();
  }

  clearPassword() {
    loginPasswordCntrllr.clear();
  }

  setLoginStatus(String accessToken) async {
    final status = await SharedPreferences.getInstance();
    status.setBool(GlobalKeys.userLoggedIN, true);
    status.setString(GlobalKeys.accesToken, accessToken);
  }

 userDataBody() {
    final body = UserLoginModel(
      email: loginEmailCntrllr.text,
      password: loginPasswordCntrllr.text,
    );

    return body;
  }

  errorResonses(FirebaseAuthException loginError, BuildContext context) {
    final statusCode = loginError.code;
    return SnackBarWidget.snackBar(context, statusCode.toString());
  }
}
