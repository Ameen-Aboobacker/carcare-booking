import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:provider/provider.dart';
import 'package:carcareuser/user_registration/view_model/firebase_auth_view_model.dart';
import 'package:carcareuser/utils/global_colors.dart';

class OtpTextfieldWidget extends StatelessWidget {
  const OtpTextfieldWidget({super.key});
  

  @override
  Widget build(BuildContext context) {
    final firebaseAuthViewModel = context.read<FirebaseAuthViewModel>();
    return OtpTextField(
      inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
      numberOfFields: 6,
      clearText: firebaseAuthViewModel.clearOtp,
      fieldWidth: 45,
      borderColor: AppColors.kButtonColor,
      focusedBorderColor: AppColors.kButtonColor,
      cursorColor: AppColors.black,
      onCodeChanged: (String code) {
        Provider.of<FirebaseAuthViewModel>(context, listen: false).setOtp(code);
      },
      onSubmit: (String verificationCode) {
        Provider.of<FirebaseAuthViewModel>(context, listen: false)
            .setOtp(verificationCode);
      },
    );
  }
}
