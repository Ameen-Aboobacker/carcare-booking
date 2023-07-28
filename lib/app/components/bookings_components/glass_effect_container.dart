import 'dart:ui';
import 'package:flutter/material.dart';

class GlassEffect {
  static Widget glassEffect({
    required BuildContext context,
    required Widget child,
    double? height = 90
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Stack(children: [
        BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 7,
            sigmaY: 7,
          ),
          child:  SizedBox(
            height:height,
            width: double.infinity,
          ),
        ),
        Container(
          height: height,
          width: double.infinity,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
              )
            ],
            // border:
            //     Border.all(color: Colors.white.withOpacity(0.2), width: 1.0),
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.5),
                Colors.white.withOpacity(0.2)
              ],
              stops: const [0.0, 1.0],
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: child,
          ),
        ),
      ]),
    );
  }
}
