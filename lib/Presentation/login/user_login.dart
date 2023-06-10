
import 'package:carcareuser/Presentation/widgets/login_form.dart';
import 'package:flutter/material.dart';

class UserLogin extends StatefulWidget {
  final VoidCallback showSignUp;
  const UserLogin({
    Key? key, required this.showSignUp,
  }) : super(key: key);

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoginForm(
                  
                  onpressed:widget.showSignUp ,
                  navigateTo: 'user',
                  title: 'Welcome',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
