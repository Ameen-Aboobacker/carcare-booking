import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carcareuser/user_registration/components/text_form_field.dart';
import 'package:carcareuser/user_registration/view_model/forget_password_view_model.dart';
import 'package:carcareuser/utils/global_colors.dart';
import 'package:carcareuser/utils/global_values.dart';

class ChangePassView extends StatelessWidget {
  ChangePassView({super.key});
  final _changepassKey = GlobalKey<FormState>();

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
            child: Form(
              key: _changepassKey,
              child: ListView(
                children: [
                  const SizedBox(height: 20,),
                  const Text(
                    "Create a new password",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 19,
                      color: AppColors.black,
                    ),
                  ),
                  AppSizes.kHeight50,
                  TextFormWidget(
                      isPassword: true,
                      controller: forgetPassViewModel.newpasswordController,
                      labelText: "New password",
                      textFieldIcon: Icons.lock,
                      keyType: TextInputType.text,
                      ),
                  TextFormWidget(
                      isConfPass: true,
                      controller: forgetPassViewModel.newConfpasswordController,
                      labelText: "Confirm Password",
                      textFieldIcon: Icons.lock,
                      keyType: TextInputType.text,
                      isForgetPass: true,
                      ),
                  AppSizes.kHeight30,
                  SizedBox(
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_changepassKey.currentState!.validate()) {
                          context.read<ForgetPassViewModel>().setNewPassword(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(elevation: 0),
                      child: forgetPassViewModel.isLoading
                          ? const CircularProgressIndicator(
                              color: AppColors.white,
                              strokeWidth: 3,
                            )
                          : const Text("SUBMIT"),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
