import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../utils/global_colors.dart';
import '../../utils/global_values.dart';
import '../../utils/routes/navigations.dart';
import '../../utils/textstyles.dart';
import '../components/curved_background.dart';

import '../components/login_button_widget.dart';
import '../components/registering_text_widget.dart';
import '../components/text_form_field.dart';
import '../view_model/sign_up_view_model.dart';
import 'login_view.dart';

class UserSignUpScreen extends StatelessWidget {
  const UserSignUpScreen({super.key});




  @override
  Widget build(BuildContext context) {

 
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: AppColors.appColor));
    final size = MediaQuery.of(context).size;
   
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: size.width,
            height: size.height,
            color: AppColors.white,
            child: CustomPaint(
              painter: CurvePainter(),
            ),
          ),
          GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: const Center(
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 20),
                child: SignupFormWidget(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SignupFormWidget extends StatelessWidget {
  const SignupFormWidget({
    super.key,
  });

 

  @override
  Widget build(BuildContext context) {
     final formKey = GlobalKey<FormState>();
     final signUpProvider = Provider.of<SignUpViewModel>(context,listen: false);
    TextEditingController userNameController =
        signUpProvider.userNameController;
    TextEditingController phoneController = signUpProvider.phoneController;
    TextEditingController userEmailController = signUpProvider.emailController;
    TextEditingController passController = signUpProvider.passController;
    TextEditingController confirfPassController =
        signUpProvider.confirfPassController;
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppSizes.kHeight50,
            Text("Create Account",
                style: AppTextStyles.loginHeading),
            const Text(
              "Let,s have some Fun",
              style: TextStyle(
                  // color: AppColors.kGreyColor,
                  ),
            ),
            AppSizes.kHeight50,
            TextFormWidget(
              isUser: true,
              controller: userNameController,
              labelText: 'Name',
              textFieldIcon: Icons.person_outline,
              keyType: TextInputType.text,
            ),
            TextFormWidget(
              ismail: true,
              controller: userEmailController,
              labelText: 'Email',
              textFieldIcon: Icons.person_outline,
              keyType: TextInputType.text,
            ),
            TextFormWidget(
              isPhone: true,
              controller: phoneController,
              labelText: 'Phone',
              textFieldIcon: Icons.phone_iphone,
              keyType: TextInputType.number,
            ),
            TextFormWidget(
              isPassword: true,
              controller: passController,
              labelText: 'Password',
              textFieldIcon: Icons.lock_outline,
              keyType: TextInputType.text,
            ),
            TextFormWidget(
              isConfPass: true,
              controller: confirfPassController,
              labelText: 'Confirm Password',
              textFieldIcon: Icons.lock_outline,
              keyType: TextInputType.text,
            ),
            AppSizes.kHeight10,
            // const ImagePickerWidget(),
            // AppSizes.kHeight40,
            LoginButtonWidget(
              title: "CREATE ACCOUNT",
              onPressed: 
                  () async {
                      if (formKey.currentState!.validate()) {
                        await context
                            .read<SignUpViewModel>()
                            .signUp(context);
                      }
                    },
            ),
            AppSizes.kHeight30,
            RegisteringText(
              leftText: 'Already have an account? ',
              rightText: "Login",
              onTap: () {
                Navigator.push(
                  context,
                  NavigatorClass.animatedRoute(
                    route: const UserLoginScreen(),
                  ),
                );

                context.read<SignUpViewModel>().clearTextField();
                // context.read<SignUpViewModel>().setImage(null);
                context
                    .read<SignUpViewModel>()
                    .checkTextFieldisEmpty();
              },
            )
          ],
        ),
      ),
    );
  }
}
