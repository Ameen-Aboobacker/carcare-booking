import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/snackbar.dart';

class FirebaseExceptions {
  final BuildContext context;
  FirebaseExceptions(this.context);
   
   void cases(FirebaseAuthException error) {
    SnackBarWidget snackbar=SnackBarWidget(context);
    switch (error.code) {
      case "invalid-email":
    snackbar.snackBar(message:"Invalid email");
        break;

      case "user-not-found":
        snackbar.snackBar(message:"email not registered");
        break;

      case "network-request-failed":
        snackbar.snackBar(message:"No internet connection");
        break;

       case "wrong-password":
        snackbar.snackBar(message:"Incorrect password.");
        break;

       case "too-many-requests":
        snackbar.snackBar(message:"chances exceeded.try again later");
        break;
        case "email-already-in-use":
        snackbar.snackBar(message:"email already registered");
        break;
      default:
        log(error.code);
        snackbar.snackBar(message:error.message!);
    }
  }
}