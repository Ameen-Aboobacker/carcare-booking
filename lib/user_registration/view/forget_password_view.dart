import 'package:carcareuser/user_registration/view_model/forget_password_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carcareuser/user_registration/components/text_form_field.dart';

import 'package:carcareuser/user_registration/view_model/sign_up_view_model.dart';

import '../../utils/global_colors.dart';
import '../../utils/global_values.dart';
import '../../utils/textstyles.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});
  final forgetKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final forgetPassViewModel = context.watch<ForgetPassViewModel>();
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
                  "Enter the registered Email  here.",
                  style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                AppSizes.kHeight30,
                Form(
                  key: forgetKey,
                  child: TextFormWidget(
                    ismail:true,
                    controller: forgetPassViewModel.emailController,
                    labelText: "Email",
                    textFieldIcon: Icons.mail_outline,
                    keyType: TextInputType.emailAddress,
                  ),
                ),
                AppSizes.kHeight30,
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {
                      if (forgetKey.currentState!.validate()) {
                        forgetPassViewModel.getForgetPassStatus(context,
                            forgetPassViewModel.emailController.text.trim());
                                 
                      }
                    },
                    style: ElevatedButton.styleFrom(elevation: 0),
                    child: forgetPassViewModel.isLoading?const CircularProgressIndicator():const Text("Reset Password"),
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
