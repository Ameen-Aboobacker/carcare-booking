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
        SnackBarWidget.snackBar(context, "invalid user");
        break;

      case "network-request-failed":
        SnackBarWidget.snackBar(context, "No internet connection");
        break;

       case "wrong-password":
        SnackBarWidget.snackBar(context, "Incorrect password.");
        break;

       case "too-many-requests":
        SnackBarWidget.snackBar(context, "chances exceeded.try again later");
        break;
        case "email-already-in-use":
        SnackBarWidget.snackBar(context, "email already registered");
        break;
      default:
        log(error.code);
        SnackBarWidget.snackBar(context, error.message!);
    }
  }
}