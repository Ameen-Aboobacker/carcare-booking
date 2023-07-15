import 'package:flutter/material.dart';

class SnackBarWidget {
  final BuildContext context;
  SnackBarWidget(this.context);
   snackBar({required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
