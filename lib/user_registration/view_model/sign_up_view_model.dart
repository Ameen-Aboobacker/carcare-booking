
import 'package:carcareuser/user_registration/model/firebase_exeptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../utils/keys.dart';
import '../../utils/routes/navigations.dart';

import '../../utils/session_controller.dart.dart';
import '../components/snackbar.dart';
import '../model/error_response_model.dart';
import '../model/user_signup_model.dart';

class SignUpViewModel with ChangeNotifier {
  final TextEditingController userNameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController confirfPassController = TextEditingController();
  FirebaseAuth auth=FirebaseAuth.instance;
  FirebaseFirestore db=FirebaseFirestore.instance; 
  bool _isShowPassword = true;
  bool _isShowConfPassword = true;
  bool _isLoading = false;
  UserSignupModel? _userData;

  bool get isShowPassword => _isShowPassword;
  bool get isShowConfPassword => _isShowConfPassword;
  bool get isLoading => _isLoading;
  UserSignupModel get userData => _userData!;

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

 signUp(BuildContext context) async {
    final navigator = Navigator.of(context);
    setLoading(true);
    UserSignupModel userData = userSignupData();
    try {
      auth.createUserWithEmailAndPassword(
        email: userData.email!,
        password: userData.password!,
      ).then((value) {
        userData.id=value.user!.uid;

        db.collection('user').doc(value.user!.uid).set(userData.toJson());
        setSignupStatus(value.user!.uid);
        setLoading(false);
        notifyListeners();
        SnackBarWidget.snackBar(context, 'User created Successfully!!');
        navigator.pushNamedAndRemoveUntil(
            NavigatorClass.mainScreen, (route) => false);
      }).onError<FirebaseAuthException>((error, stackTrace) {
       FirebaseExceptions.cases(error,context);
        setLoading(false);
      });
    }on FirebaseAuthException catch (e) {
      setLoading(false);
        SnackBarWidget.snackBar(context,e.code);
    }
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

   userSignupData() {
    final body = UserSignupModel(
      name: userNameController.text,
      email:emailController.text,
      mobile: phoneController.text,
      password: passController.text,
    );
    return body;
  }

}