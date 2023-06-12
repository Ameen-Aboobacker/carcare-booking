import 'package:carcareuser/services/authentication.dart';
import 'package:carcareuser/utils/routes/navigations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/keys.dart';
import '../components/snackbar.dart';
import '../model/user_signup_model.dart';

class SignUpViewModel with ChangeNotifier {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController confirfPassController = TextEditingController();

  bool _isShowPassword = true;
  bool _isShowConfPassword = true;
  bool _isLoading = false;
  FirebaseAuthException? _signUpError;
  UserSignupModel? _userData;

  bool get isShowPassword => _isShowPassword;
  bool get isShowConfPassword => _isShowConfPassword;
  bool get isLoading => _isLoading;
  UserSignupModel get userData => _userData!;
FirebaseAuthException get signUpError => _signUpError!;

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

  UserSignupModel? setUserData(UserSignupModel userData)  {
    _userData = userData;
    return _userData;
  }

  setLoginError(FirebaseAuthException signUpError, context) async {
    _signUpError = signUpError;
    return errorResonses(_signUpError!, context);
  }

  getSignUpStatus(BuildContext context,String id) async {
    final navigator = Navigator.of(context);
    setLoading(true);
  try {
    userDatabody().accessToken=id;
    await AuthService().db.collection('user').doc(id).set(userDatabody().toJson());
    await setSignupStatus(id);
    navigator.pushNamed(NavigatorClass.mainScreen);
  }on FirebaseAuthException catch (e) {
    setLoginError(e, context);
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

  UserSignupModel userDatabody() {
    final body = UserSignupModel(
      name: userNameController.text,
      mobile: phoneController.text,
      password: passController.text,
    );
    return body;
  }

  errorResonses(FirebaseAuthException signUperror, BuildContext context) {
    final statusCode = signUperror.code;
    return SnackBarWidget.snackBar(context, statusCode.toString());
  }
}