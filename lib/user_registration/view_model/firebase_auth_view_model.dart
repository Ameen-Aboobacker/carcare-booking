import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carcareuser/user_registration/components/snackbar.dart';

import 'package:carcareuser/user_registration/view_model/sign_up_view_model.dart';
import 'package:carcareuser/utils/keys.dart';
import '../../utils/routes/navigations.dart';
import '../model/firebase_exeptions.dart';
import '../view/otp_page_view.dart';

class FirebaseAuthViewModel with ChangeNotifier {
  final googleSigin = GoogleSignIn();
  GoogleSignInAccount? _user;
  bool _isLoadingOtp = false;
  bool _clearOtp = false;
  String _verifyOTP = '';
  String otpValue = '';
  int? _otpResendToken;

  bool get isLoadingOtp => _isLoadingOtp;
  GoogleSignInAccount get user => _user!;
  String get verifyOTP => _verifyOTP;
  int get otpResendToken => _otpResendToken!;
  bool get clearOtp => _clearOtp;

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
      await FirebaseAuth.instance.signInWithCredential(credential);
      navigator.pushReplacementNamed(NavigatorClass.mainScreen);
      final sharedPref = await SharedPreferences.getInstance();
      sharedPref.setBool(GlobalKeys.userLoggedWithGoogle, true);
    } on PlatformException catch (e) {
      log(e.code);
      SnackBarWidget.snackBar(context, "No internet connection");
    } on FirebaseAuthException catch (e) {
      FirebaseExpeptions.cases(e, context);
    }
    notifyListeners();
  }

  setOtpLoading(bool loadingOtp) {
    _isLoadingOtp = loadingOtp;
    notifyListeners();
  }

  fireBasePhoneAuth(
    BuildContext context,
    String mobileNumber,
    bool isForgotPass,
  ) async {
    setOtpLoading(true);
    String countryCode = "+91";
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: countryCode + mobileNumber,
      verificationCompleted: (PhoneAuthCredential credential) {
        log("Credential");
      },
      verificationFailed: (FirebaseAuthException error) {
        log("Error");
        setOtpLoading(false);
        FirebaseExpeptions.cases(error, context);
      },
      codeSent: (String verificationId, int? resendToken) {
        log("code sent");
        _otpResendToken = resendToken;
        _verifyOTP = verificationId;
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => OtpVerificationPage(isForgotPass: isForgotPass),
        ));
        setOtpLoading(false);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        log("time out");
      },
    );
    notifyListeners();
  }

  setOtp(String verificationCode) {
    otpValue = verificationCode;
    notifyListeners();
  }

  clearOTP() {
    otpValue = '';
    _clearOtp = true;
    notifyListeners();
  }

  firbaseAuthenticationWithOTP(BuildContext context, bool isForgotPass) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final signUpViewModel = context.read<SignUpViewModel>();
    final navigator = Navigator.of(context);
    setOtpLoading(true);
    try {
      log('came here');
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verifyOTP,
        smsCode: otpValue,
      );
     final cred= await auth.signInWithCredential(credential);
      clearOTP();
      isForgotPass
          ? navigator.pushNamed(NavigatorClass.changeforgetPass)
          : await signUpViewModel.getSignUpStatus(context,cred.user!.uid);
      setOtpLoading(false);
    } on SocketException {
      log("No internet");
      SnackBarWidget.snackBar(context, "No internet connection");
    } on PlatformException {
      SnackBarWidget.snackBar(context, "No internet connection");
    } on FirebaseAuthException catch (error) {
      FirebaseExpeptions.cases(error, context);
    }
    setOtpLoading(false);
  }

  resentOTPtoPhone(BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String countryCode = "+91";

    await auth.verifyPhoneNumber(
      phoneNumber:
          countryCode + context.read<SignUpViewModel>().phoneController.text,
      verificationCompleted: (phoneAuthCredential) {},
      verificationFailed: (error) {},
      codeSent: (verificationId, forceResendingToken) {
        _verifyOTP = verificationId;
        _otpResendToken = forceResendingToken;
      },
      codeAutoRetrievalTimeout: (verificationId) {},
      forceResendingToken: _otpResendToken,
      timeout: const Duration(seconds: 60),
    );
  }

  // ----------- user Login status

  userLoginStatus(context) async {
    final navigator = Navigator.of(context);
    final sharedPrefer = await SharedPreferences.getInstance();
    final googleSigup = sharedPrefer.getBool(GlobalKeys.userLoggedWithGoogle);
    final userLoggedin = sharedPrefer.getBool(GlobalKeys.userLoggedIN);
    final userSignedUp = sharedPrefer.getBool(GlobalKeys.userSignedUp);
    if (googleSigup == true) {
      sharedPrefer.remove(GlobalKeys.userLoggedWithGoogle);
      await firebaseGoogleLogout();
      navigator.pushNamedAndRemoveUntil(
          NavigatorClass.loginScreen, (route) => false);
    } else if (userLoggedin == true) {
      sharedPrefer.remove(GlobalKeys.userLoggedIN);
      sharedPrefer.remove(GlobalKeys.accesToken);
      navigator.pushNamedAndRemoveUntil(
          NavigatorClass.loginScreen, (route) => false);
    } else if (userSignedUp == true) {
      sharedPrefer.remove(GlobalKeys.userSignedUp);
      sharedPrefer.remove(GlobalKeys.accesToken);
      navigator.pushNamedAndRemoveUntil(
          NavigatorClass.loginScreen, (route) => false);
    }
  }

  firebaseGoogleLogout() async {
    await googleSigin.disconnect();
    FirebaseAuth.instance.signOut();
  }
}
