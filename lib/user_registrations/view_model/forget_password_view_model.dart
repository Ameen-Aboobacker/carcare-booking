import 'package:carcareuser/user_registrations/model/firebase_exeptions.dart';
import 'package:carcareuser/utils/routes/navigations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/snackbar.dart';

class ForgetPassViewModel with ChangeNotifier {
  final TextEditingController emailController = TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  getForgetPassStatus(BuildContext context, String email) async {
    FirebaseExceptions exception=FirebaseExceptions(context);
    NavigatorState navigator = Navigator.of(context);
    setLoading(true);
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email)
          .then((value) {
        return navMethod(navigator, context, email);
      });
    } on FirebaseAuthException catch (e) {
      exception.cases(e);
    }
    setLoading(false);
  }

  void navMethod(NavigatorState navigator, BuildContext context, String email) {
   SnackBarWidget snackbar=SnackBarWidget(context);
    clearTextField();
    snackbar.snackBar(message: 'password reset link sent to $email');
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
