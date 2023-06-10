import 'package:carcareuser/Presentation/widgets/password_field.dart';

import 'package:carcareuser/Presentation/widgets/submit_button.dart';
import 'package:carcareuser/core/constants.dart';
import 'package:carcareuser/core/strings.dart';
import 'package:carcareuser/model/user_model.dart';
import 'package:carcareuser/services/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/text_field.dart';



class UserSignup extends StatefulWidget {
  const UserSignup({Key? key, required this.showLogin}) : super(key: key);
  final VoidCallback showLogin;
  @override
  State<UserSignup> createState() => _UserSignupState();
}

class _UserSignupState extends State<UserSignup> {
  final TextEditingController nameCtrl = TextEditingController();

  final TextEditingController phoneCtrl = TextEditingController();

  final TextEditingController passwordCtrl = TextEditingController();

  final TextEditingController cpasswordCtrl = TextEditingController();
  final TextEditingController mailCtrl = TextEditingController();

  final GlobalKey<FormState> formValidateKey = GlobalKey<FormState>();

  AuthService authSer = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Form(
              key: formValidateKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Create Account',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                      fontSize: 40,
                    ),
                  ),
                  const Text(
                    'Create New Account ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  kHeight,
                  TextFieldWidget(
                    icon: Icons.person,
                    controller: nameCtrl,
                    labelText: 'Name',
                    keyType: TextInputType.name,
                    isAlpha:true,
                  ),
                  kHeight8,
                  TextFieldWidget(
                    icon: Icons.mail_outline,
                    controller: mailCtrl,
                    labelText: 'Email',
                    keyType: TextInputType.name,
                  ),
                  kHeight8,
                  TextFieldWidget(
                    icon: Icons.phone_android,
                    controller: phoneCtrl,
                    labelText: 'Phone Number',
                    keyType: TextInputType.emailAddress,
                  ),
                  kHeight8,
                  PasswordField(
                    controller: passwordCtrl,
                    labelText: 'Password',
                    textType: 'password',
                  ),
                  kHeight8,
                  PasswordField(
                    controller: cpasswordCtrl,
                    labelText: 'confirm',
                    matchtext: password,
                    textType: 'cpassword',
                  ),
                  kHeight30,
                  SubmitButton(
                    name: 'SignUp',
                    onPressed: () async {
                      if(formValidateKey.currentState!.validate()){}
                      if(formValidateKey.currentState!.validate()){
                         User? result = await authSer.signUp(
                        email: mailCtrl.text.trim(),
                        password: passwordCtrl.text.trim(),
                        context: context,
                      );
                      if (result != null) {
                        UserModel user = UserModel(
                            name: nameCtrl.text.trim(),
                            email: mailCtrl.text.trim(),
                            phone: phoneCtrl.text.trim());
                        //await authSer.addUser(user);
                      }
                      }
                     
                    },
                  ),
                  kHeight8,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an Account?'),
                      TextButton(
                        onPressed: widget.showLogin,
                        child: const Text(
                          'Log In',
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
