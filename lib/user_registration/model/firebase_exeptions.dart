import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/snackbar.dart';

class FirebaseExceptions {
  static void cases(FirebaseAuthException error, BuildContext context) {
    switch (error.code) {
      case "invalid-email":
        SnackBarWidget.snackBar(context, "Invalid email");
        break;

      case "user-not-found":
        SnackBarWidget.snackBar(context, "invalid user not found");
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