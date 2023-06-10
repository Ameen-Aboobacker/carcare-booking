import 'package:carcareuser/user_registration/view_model/firebase_auth_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carcareuser/user_registration/components/snackbar.dart';
import 'package:carcareuser/user_registration/model/error_response_model.dart';
import 'package:carcareuser/user_registration/model/user_login_model.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:carcareuser/utils/keys.dart';

import '../../utils/routes/navigations.dart';

class UserLoginViewModel with ChangeNotifier {
  TextEditingController loginPhoneCntrllr = TextEditingController();
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
   /* setLoading(true);
    final response = await ApiServices.postMethod(
        url: Urls.kUSERSIGNIN,
        body: userDataBody(),
        jsonDecode: userLoginModelFromJson);

    if (response is Success) {
      final data = await setUserData(response.response as UserLoginModel);
      final accessToken = data!.accessToken;
      log(accessToken.toString());
      clearController();
      await setLoginStatus(accessToken!);
      navigator.pushReplacementNamed(NavigatorClass.mainScreen);
    }

    if (response is Failure) {
      setLoading(false);
      clearPassword();
      FirebaseAuthException loginError = FirebaseAuthException(
        code: response.code,
        message: response.errorResponse,
      );
      setLoginError(loginError, context);
    }
    setLoading(false);*/
    navigator.pushReplacementNamed(NavigatorClass.mainScreen);
  }

  clearController() {
    loginPhoneCntrllr.clear();
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

  Map<String, dynamic> userDataBody() {
    final body = UserLoginModel(
      mobile: loginPhoneCntrllr.text,
      password: loginPasswordCntrllr.text,
    );

    return body.toJson();
  }

  errorResonses(FirebaseAuthException loginError, BuildContext context) {
    final statusCode = loginError.code;
    return SnackBarWidget.snackBar(context, statusCode.toString());
  }
}
