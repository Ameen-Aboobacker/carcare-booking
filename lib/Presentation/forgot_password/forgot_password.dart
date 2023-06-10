import 'package:carcareuser/Presentation/widgets/snackbar.dart';
import 'package:carcareuser/Presentation/widgets/submit_button.dart';
import 'package:carcareuser/Presentation/widgets/text_field.dart';
import 'package:carcareuser/core/constants.dart';
import 'package:carcareuser/services/authentication.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({Key? key}) : super(key: key);
  final TextEditingController emailCtrl = TextEditingController();
  final GlobalKey<FormState> validateKey = GlobalKey<FormState>();
  final AuthService authSer=AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Enter Your Email and We will send you a Password Reset Link',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 17),
            ),
            kHeight,
            TextFieldWidget(
              controller: emailCtrl,
              labelText: 'Email',
              keyType: TextInputType.emailAddress,
              icon: Icons.mail_outline_rounded,
            ),
            kHeight20,
            SubmitButton(
              name: 'Send',
              onPressed: () async {
              String message='scucces';
               final result=await authSer.resetPassword(email: emailCtrl.text.trim());
               if(result=='true'){
               snackBar(context: context, message: message);
               }
               else{
                   
                if(result=='invalid-email'){
                  message='Enter a valid email';
                  snackBar(context: context, message: message);
                }
                else if(result=='user-not-found'){
                  message='Account With this email Not Found';
                  snackBar(context: context, message: message);
                }
                else{
                  snackBar(context: context, message: result);
                }
                
               }
              },
            ),
          ],
        ),
      ),
    );
  }
}
