import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/snackbar.dart';

class FirebaseExpeptions {
  static void cases(FirebaseAuthException error, BuildContext context) {
    switch (error.code) {
      case "invalid-phone-number":
        SnackBarWidget.snackBar(context, "Invalid Mobile Number");
        break;

      case "invalid-verification-code":
        SnackBarWidget.snackBar(context, "invalid verification code");
        break;

      case "network-request-failed":
        SnackBarWidget.snackBar(context, "No internet connection");
        break;

      default:
        log(error.code);
        SnackBarWidget.snackBar(context, "Something went wrong");
    }
  }
}