import 'package:carcareuser/user_registration/model/firebase_exeptions.dart';
import 'package:carcareuser/utils/routes/navigations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/snackbar.dart';

class ForgetPassViewModel with ChangeNotifier {
  final TextEditingController emailController = TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  getForgetPassStatus(BuildContext context, String email) async {
    NavigatorState navigator = Navigator.of(context);
    setLoading(true);
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email)
          .then((value) {
        return navMethod(navigator, context, email);
      });
    } on FirebaseAuthException catch (e) {
      print(e.code);
      FirebaseExceptions.cases(e, context);
    }
    setLoading(false);
  }

  void navMethod(NavigatorState navigator, BuildContext context, String email) {
    clearTextField();
    SnackBarWidget.snackBar(context, 'password reset link sent to $email');
    navigator.pushReplacementNamed(NavigatorClass.loginScreen);
  }

  setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  clearTextField() {
    emailController.clear();
  }
}
