import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class SnackBarWidget {
 static snackBar(
    BuildContext context,
    String message,
  ) {
    return Flushbar(
      message: message,
      icon: Icon(
        Icons.info_outline,
        size: 28.0,
        color: Colors.blue[300],
      ),
      duration: const Duration(seconds: 3),
      leftBarIndicatorColor: Colors.blue[300],
    )..show(context);
  }
}
