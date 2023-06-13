
import 'package:carcareuser/user_registration/view_model/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../utils/keys.dart';
import '../../utils/routes/navigations.dart';

import '../model/error_response_model.dart';
import '../model/user_signup_model.dart';

class SignUpViewModel with ChangeNotifier {
  final TextEditingController userNameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController confirfPassController = TextEditingController();

  bool _isShowPassword = true;
  bool _isShowConfPassword = true;
  bool _isLoading = false;
  ErrorResponseModel? _signUpError;
  UserSignupModel? _userData;

  bool get isShowPassword => _isShowPassword;
  bool get isShowConfPassword => _isShowConfPassword;
  bool get isLoading => _isLoading;
  UserSignupModel get userData => _userData!;
  ErrorResponseModel get signUpError => _signUpError!;

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

  Future<UserSignupModel?> setUserData(UserSignupModel userData) async {
    _userData = userData;
    return _userData;
  }

  getSignUpStatus(BuildContext context) async {
    final navigator = Navigator.of(context);
    setLoading(true);
   final  userData=userDatabody();
    final response=await Authentication().userSingnUp(userData,context);
    if(response!=null){
      print(response);
      setSignupStatus(response);
      clearTextField();
      navigator.pushReplacementNamed(NavigatorClass.mainScreen);
    }
    
    setLoading(false);
  }

  setSignupStatus(accessToken) async {
    final status = await SharedPreferences.getInstance();
    await status.setBool(GlobalKeys.userSignedUp, true);
    await status.setString(GlobalKeys.accesToken, accessToken);
  }

  clearPassword() {
    passController.clear();
    confirfPassController.clear();
  }

   userDatabody() {
    final body = UserSignupModel(
      name: userNameController.text,
      email:emailController.text,
      mobile: phoneController.text,
      password: passController.text,
    );
    return body;
  }

}