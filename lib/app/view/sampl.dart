import 'package:carcareuser/app/view_model/bottom_nav_provider.dart';
import 'package:carcareuser/app/view_model/user_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Sampl extends StatelessWidget {
const Sampl({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: TextButton(onPressed: (){
          context.read<UserProfileProvider>().signOut(context);
        }, child: Text('signOUt')),
      ),
    );
  }
}