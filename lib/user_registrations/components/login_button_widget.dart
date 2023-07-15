
import 'package:carcareuser/user_registrations/view_model/forget_password_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carcareuser/utils/global_colors.dart';

import '../../app/view_model/vehicle_provider.dart';
import '../view_model/sign_up_view_model.dart';
import '../view_model/user_login_view_model.dart';

class LoginButtonWidget extends StatelessWidget {
  const LoginButtonWidget({
    super.key,
    required this.onPressed,
    required this.title,
    this.isLogin = false,
    this.isDialog = false,

  });

  final VoidCallback? onPressed;
  final String title;
  final bool isLogin;
  final bool isDialog;

  @override
  Widget build(BuildContext context) {
    final userSignupViewModel = context.watch<SignUpViewModel>();
    final userLoginViewModel = context.watch<UserLoginViewModel>();
    final userForgetPassViewModel = context.watch<ForgetPassViewModel>();
    final vehicleScreenModel = context.watch<VehicleProvider>();

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        disabledBackgroundColor: AppColors.grey,
        elevation: 0,
        backgroundColor: AppColors.kButtonColor,
      ),
      onPressed: onPressed,
      child: isDialog?
          vehicleScreenModel.isLoading? const CircularProgressIndicator(
              strokeWidth: 3,
              color: AppColors.white,
            )
          :Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ):
      SizedBox(
        width: double.infinity,
        height: 50,
        child: Center(
          child: userSignupViewModel.isLoading ||
                  userLoginViewModel.isLoading ||
                  userForgetPassViewModel.isLoading
              ? const CircularProgressIndicator(
                  strokeWidth: 3,
                  color: AppColors.white,
                )
              : Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
        ),
      ),
    );
  }
}
