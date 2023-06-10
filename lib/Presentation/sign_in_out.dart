import 'package:carcareuser/Presentation/login/user_login.dart';
import 'package:carcareuser/Presentation/signup/signup.dart';

import 'package:flutter/material.dart';

class SignInOut extends StatefulWidget {
  const SignInOut({ Key? key }) : super(key: key);

  @override
  SignInOutState createState() => SignInOutState();
}
 
   
class SignInOutState extends State<SignInOut> {
 bool isSignin=true;
 void toggleScreen(){
  setState(() {
    isSignin=!isSignin;
  });
 }
  @override
  Widget build(BuildContext context) {
   if(isSignin){
    return  UserLogin(showSignUp: toggleScreen,);
   }
   else{
    return   UserSignup(showLogin: toggleScreen,);
   }
  }
}