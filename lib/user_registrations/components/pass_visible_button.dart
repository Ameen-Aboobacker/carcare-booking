import 'package:flutter/material.dart';

class PassVisibleButton extends StatelessWidget {
  const PassVisibleButton({
    super.key,
    required this.isShowPassword,
    required this.onTap,
  });

  final bool isShowPassword;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: isShowPassword
          ? const Icon(Icons.visibility_off)
          : const Icon(Icons.visibility),
    );
  }
}