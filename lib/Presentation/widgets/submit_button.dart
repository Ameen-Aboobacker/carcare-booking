import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    super.key,
    required this.onPressed,
    required this.name,
    this.color,
    this.textColor,
  });

  final Function() onPressed;
  final String name;
  final Color? color;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        textStyle: const TextStyle(
          fontSize: 20,
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
      ),
      onPressed: onPressed,
      child: Text(
        name,
        style: TextStyle(color: textColor),
      ),
    );
  }
}
