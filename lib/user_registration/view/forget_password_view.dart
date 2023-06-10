import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carcareuser/user_registration/components/text_form_field.dart';

import 'package:carcareuser/user_registration/view_model/sign_up_view_model.dart';

import '../../utils/global_colors.dart';
import '../../utils/global_values.dart';
import '../../utils/textstyles.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});
  final _forgetKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final forgetPassViewModel = context.watch<SignUpViewModel>();
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              children: [
                AppSizes.kHeight50,
                Text(
                  "Forgot Password ?",
                  style: AppTextStyles.loginHeading,
                ),
                AppSizes.kHeight10,
                const Text(
                  "Enter the registered mobile number here.",
                  style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                AppSizes.kHeight30,
                Form(
                  key: _forgetKey,
                  child: TextFormWidget(
                    controller: forgetPassViewModel.phoneController,
                    labelText: "Phone",
                    textFieldIcon: Icons.phone_iphone_rounded,
                    keyType: TextInputType.phone,
                    isLoginPhone: true,
                  ),
                ),
                AppSizes.kHeight30,
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: 
                         () {
                           
                          },
                    style: ElevatedButton.styleFrom(elevation: 0),
                    child: const Text("Send OTP"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
