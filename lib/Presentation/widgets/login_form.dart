
import 'package:carcareuser/Presentation/widgets/password_field.dart';
import 'package:carcareuser/Presentation/widgets/snackbar.dart';
import 'package:carcareuser/Presentation/widgets/submit_button.dart';
import 'package:carcareuser/Presentation/widgets/text_field.dart';
import 'package:carcareuser/core/constants.dart';
import 'package:carcareuser/services/authentication.dart';

import 'package:flutter/material.dart';

import '../forgot_password/forgot_password.dart';

class LoginForm extends StatelessWidget {
  LoginForm({
    super.key,
    required this.navigateTo,
    required this.title,
    required this.onpressed,
  });
  final String navigateTo;
  final String title;
  final VoidCallback onpressed;

  final GlobalKey<FormState> formValidateKey = GlobalKey<FormState>();

  final TextEditingController phoneCtrl = TextEditingController();

  final TextEditingController passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    /* void otp() {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => const OtpScreen()));
    }*/
    AuthService authSer = AuthService();
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Form(
          key: formValidateKey,
          child: Column(
            children: [
              kHeight15,
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                  fontSize: 40,
                ),
              ),
              const Text(
                'Sign in to Continue ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              kHeight15,
              TextFieldWidget(
                icon: Icons.mail_outline,
                controller: phoneCtrl,
                labelText: 'Email',
                keyType: TextInputType.emailAddress,
              ),
              kHeight8,
              PasswordField(
                controller: passwordCtrl,
                labelText: 'Password',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => ForgotPassword()));
                    },
                    child: const Text(
                      "Forgot Password?",
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
              SubmitButton(
                name: 'Log In',
                onPressed: () async {
                   
                   
                if(formValidateKey.currentState!.validate()){
                   final result = await authSer.signIn(
                    email: phoneCtrl.text.trim(),
                    password: passwordCtrl.text.trim(),
                    context: context,
                  );
                  if (result == null) {
                    snackBar(context: context, message: result);
                  } else {
                    snackBar(
                        context: context, message: 'Signed in with id:$result');
                  }
                }
                },
              ),
              kHeight8,
              const Text('OR'),
              kHeight8,
              SubmitButton(
                name: 'Sign in With Google',
                onPressed: () async {
                  final data = await authSer.signInWithGoogle();
                  print(data.user!.displayName);
                },
              ),
              kHeight,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text('Dont have Account?'),
                  TextButton(
                    onPressed: onpressed,
                    child: const Text(
                      'Create New Account',
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
