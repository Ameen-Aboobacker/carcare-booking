import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carcareuser/user_registration/components/otp_textfield.dart';
import 'package:carcareuser/user_registration/view_model/firebase_auth_view_model.dart';
import 'package:carcareuser/utils/global_colors.dart';
import 'package:carcareuser/utils/global_values.dart';
import 'package:carcareuser/utils/textstyles.dart';
import 'package:carcareuser/user_registration/view_model/sign_up_view_model.dart';

class OtpVerificationPage extends StatelessWidget {
  final bool isForgotPass;
  const OtpVerificationPage({
    super.key,
    this.isForgotPass = false,
  });

  @override
  Widget build(BuildContext context) {
    bool isVisible = true;
    bool isResentOn = true;
    final otpValue = Provider.of<FirebaseAuthViewModel>(context).otpValue;
    final mobileNumber = isForgotPass
        ? Provider.of<SignUpViewModel>(context).phoneController
        : Provider.of<SignUpViewModel>(context).phoneController;
    final firebaseViewModel = context.watch<FirebaseAuthViewModel>();
    final splitOtp = otpValue.split('');
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          Provider.of<FirebaseAuthViewModel>(context, listen: false).clearOTP();
          return true;
        },
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppSizes.kHeight30,
                      Text(
                        "OTP Verification",
                        style: AppTextStyles.loginHeading,
                      ),
                      Center(
                        child: SizedBox(
                          width: 200,
                          height: 180,
                          child: Image.asset("assets/otp_pic.png"),
                        ),
                      ),
                      Text(
                        "Enter the verification code we just sent you\non mobile +91${mobileNumber.text}",
                        style: const TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      AppSizes.kHeight30,
                      const OtpTextfieldWidget(),
                      AppSizes.kHeight30,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TweenAnimationBuilder(
                            tween: Tween(begin: 1.0, end: 0.0),
                            duration: const Duration(seconds: 30),
                            builder: (context, value, child) {
                              int seconds = (value * 30).ceil();
                              seconds = seconds % 60;
                              isResentOn = seconds <= 0;
                              return Visibility(
                                visible: isResentOn,
                                child: GestureDetector(
                                  onTap: () {
                                    context
                                        .read<FirebaseAuthViewModel>()
                                        .resentOTPtoPhone(context);
                                  },
                                  child: const Text(
                                    "Resend ",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.kButtonColor,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          TweenAnimationBuilder(
                            tween: Tween(begin: 1.0, end: 0.0),
                            duration: const Duration(seconds: 30),
                            builder: (context, value, child) {
                              int seconds = (value * 30).ceil();
                              seconds = seconds % 60;
                              String formattedTime =
                                  seconds.toString().padLeft(2, '0');
                              isVisible = seconds > 0;
                              return Visibility(
                                visible: isVisible,
                                child: Text(
                                  "Resend in $formattedTime",
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.grey,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      AppSizes.kHeight40,
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: splitOtp.length != 6
                              ? null
                              : () {
                               
                                 context
                                      .read<FirebaseAuthViewModel>()
                                      .firbaseAuthenticationWithOTP(
                                          context, isForgotPass);
                                },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                          ),
                          child: firebaseViewModel.isLoadingOtp
                              ? const CircularProgressIndicator(
                                  color: AppColors.white,
                                  strokeWidth: 2,
                                )
                              : const Text(
                                  "Verify",
                                  style: TextStyle(fontSize: 16),
                                ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
