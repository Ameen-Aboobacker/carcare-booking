import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:carcareuser/user_registration/view/login_view.dart';
import 'package:carcareuser/utils/global_colors.dart';
import 'package:carcareuser/utils/global_values.dart';
import 'package:carcareuser/utils/textstyles.dart';
import 'package:carcareuser/user_registration/view_model/sign_up_view_model.dart';
import '../../utils/routes/navigations.dart';
import '../components/curved_background.dart';
import '../components/login_button_widget.dart';
import '../components/registering_text_widget.dart';
import '../components/text_form_field.dart';

class UserSignUpScreen extends StatefulWidget {
  const UserSignUpScreen({super.key});

  @override
  State<UserSignUpScreen> createState() => _UserSignUpScreenState();
}

class _UserSignUpScreenState extends State<UserSignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController countryCode = TextEditingController();

  @override
  void initState() {
    countryCode.text = "+91";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: AppColors.appColor));
    final size = MediaQuery.of(context).size;
    final signUpProvider = context.watch<SignUpViewModel>();
    TextEditingController userNameController =
        signUpProvider.userNameController;
    TextEditingController phoneController = signUpProvider.phoneController;
    TextEditingController userEmailController = signUpProvider.emailController;
    TextEditingController passController = signUpProvider.passController;
    TextEditingController confirfPassController =
        signUpProvider.confirfPassController;
    return Scaffold(
      body: Stack(
        children: [
          // SvgPicture.asset("assets/login_top.svg"),
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
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _formKey,
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
                          isUser: true,
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
                        AppSizes.kHeight40,
                        LoginButtonWidget(
                          title: "CREATE ACCOUNT",
                          onPressed: userNameController.text.isEmpty ||
                                  phoneController.text.isEmpty ||
                                  passController.text.isEmpty ||
                                  confirfPassController.text.isEmpty||
                                  userEmailController.text.isEmpty
                              ? null
                              :() async {
                                  if (_formKey.currentState!.validate()) {
                                    await context
                                        .read<SignUpViewModel>()
                                        .getSignUpStatus(context);
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
                            context
                                .read<SignUpViewModel>()
                                .checkTextFieldisEmpty();
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
