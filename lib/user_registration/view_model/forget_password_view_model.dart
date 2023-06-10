
import 'package:flutter/material.dart';




import '../components/snackbar.dart';


class ForgetPassViewModel with ChangeNotifier {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController newpasswordController = TextEditingController();
  final TextEditingController newConfpasswordController =
      TextEditingController();

  bool _isLoadingOtp = false;
  bool _isLoading = false;
  bool get isLoadingotp => _isLoadingOtp;
  bool get isLoading => _isLoading;

  getForgetPassStatus(BuildContext context) async {
   
  }

  setNewPassword(context) async {
   
  }

  Map<String, dynamic> newPassBody() {
    Map<String, dynamic> body = {
      "mobile": phoneController.text.trim(),
      "pwd": newpasswordController.text.trim(),
    };

    return body;
  }

  setLoadingOtp(bool loading) {
    _isLoadingOtp = loading;
    notifyListeners();
  }

  setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  clearTextField() {
    newpasswordController.clear();
    newConfpasswordController.clear();
    phoneController.clear();
  }

  errorResonses(int? statusCode, Object? message, BuildContext context) {
    if (statusCode == 404) {
      return SnackBarWidget.snackBar(
          context, "Could not find the mobile number");
    }
    return SnackBarWidget.snackBar(context, message.toString());
  }
}
