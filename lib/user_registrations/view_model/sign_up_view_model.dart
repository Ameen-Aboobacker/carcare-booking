import 'dart:io';

import 'package:carcareuser/utils/routes/auth_service.dart';
import 'package:carcareuser/user_registrations/model/firebase_exeptions.dart';
import 'package:carcareuser/user_registrations/model/user_signup_model.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/keys.dart';
import '../../utils/routes/navigations.dart';

import '../model/status.dart';


class SignUpViewModel with ChangeNotifier {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController confirfPassController = TextEditingController();

  bool _isShowPassword = true;
  bool _isShowConfPassword = true;
  bool _isLoading = false;
  UserSignupModel? _userData;
  File? _image;

  UserProvider? userp;

  bool get isShowPassword => _isShowPassword;
  bool get isShowConfPassword => _isShowConfPassword;
  bool get isLoading => _isLoading;
  UserSignupModel get userData => _userData!;
  File? get image => _image;

  setshowPassword() {
    _isShowPassword = !_isShowPassword;
    notifyListeners();
  }

  setshowConfPassword() {
    _isShowConfPassword = !_isShowConfPassword;
    notifyListeners();
  }

  checkTextFieldisEmpty() {
    notifyListeners();
  }

  clearTextField() {
    userNameController.clear();
    phoneController.clear();
    passController.clear();
    confirfPassController.clear();
  }

  setLoading(bool loading) async {
    _isLoading = loading;
    notifyListeners();
  }

  signUp(BuildContext context) async {
    final navigator = Navigator.of(context);
    final exception = FirebaseExceptions(context);
    setLoading(true);
    final userData = userSignupData();
    final response = await userp!.signUp(userData, context);
    setLoading(false);
    if (response is Success) {
      navigator.pushNamedAndRemoveUntil(
          NavigatorClass.homeScreen, (route) => false);
    }
    if (response is Failure) {
      exception.cases(response.errorResponse!);
    }

    notifyListeners();
  }

  setSignupStatus(String accessToken) async {
    final status = await SharedPreferences.getInstance();
    await status.setBool(GlobalKeys.userSignedUp, true);
    await status.setString(GlobalKeys.accesToken, accessToken);
  }

  clearPassword() {
    passController.clear();
    confirfPassController.clear();
  }

  UserSignupModel userSignupData() {
    final body = UserSignupModel(
      name: userNameController.text,
      email: emailController.text,
      mobile: phoneController.text,
      password: passController.text,
    );
    return body;
  }
}
