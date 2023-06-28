import 'package:carcareuser/user_registration/model/user_signup_model.dart';
import 'package:carcareuser/utils/routes/paths.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../utils/api_status.dart';

class FirebaseServices{
  FirebaseAuth auth=FirebaseAuth.instance;
  signup(UserSignupModel user)async{
   try {
     final userCred= await auth.createUserWithEmailAndPassword(email: user.email!, password: user.password!);
     user.id=userCred.user!.uid;
     final result=FirebasePaths.userpath(userCred.user!.uid).set(user);
   }on FirebaseAuthException catch (e) {
     return Failure(errorResponse: e);
   }
  }
}
