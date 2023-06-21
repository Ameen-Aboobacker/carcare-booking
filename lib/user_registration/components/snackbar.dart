import 'package:flutter/material.dart';

class SnackBarWidget {
  static snackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        padding: const EdgeInsets.all(20),
        behavior: SnackBarBehavior.floating,
        content: Text(message,style: const TextStyle(fontSize: 16),),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
