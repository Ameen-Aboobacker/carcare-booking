import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:carcareuser/Presentation/widgets/snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

import '../model/service_center_model.dart';
import '../user_registration/model/user_signup_model.dart';



class AuthService  {

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db=FirebaseFirestore.instance;
  FirebaseStorage store=FirebaseStorage.instance; 
  

  Future signInAnon() async {
    try {
      UserCredential result = await auth.signInAnonymously();
      User? user = result.user;
      return user;
    } catch (e) {
      return null;
    }
  }
  Future logOut()async{
   try {
      return await auth.signOut();
   } catch (e) {
     stderr.write('ERROR :${e.toString()}');
     return null;
   }
  }
  Future signUp({required String email,required String password,required context})async {
     try {
        UserCredential result=await auth.createUserWithEmailAndPassword(email: email, password: password);
        User? user = result.user;
      return user;
     }on FirebaseAuthException catch (e) {
       snackBar(context: context, message: e.code);
     }
  }
  Future signIn({required String email,required String password,required  context}) async{
    try {
      UserCredential result=await auth.signInWithEmailAndPassword(email:email , password: password);
      User? user=result.user;
      snackBar(context: context, message: user!.uid);
    }on FirebaseAuthException catch (e) {
    snackBar(context: context, message:e.code );
      
    }
  }
  Future  resetPassword({required String email})async{
         try {
           await auth.sendPasswordResetEmail(email:email);
           return 'true';
         }on FirebaseAuthException catch  (e) {
           return e.code;
         }
  }
  Future addUser(UserSignupModel user,String id)async{
    try {
     await db.collection('user').doc(id).set(user.toJson());
    }on FirebaseAuthException catch (e) {
      
    }
  } 
   Future addCenter(ServiceCenterModel center)async{
     final refID=await db.collection('servicecenters').add(center.toJson());
     center.id=refID.id;
     await db.collection('servicecenters').doc(refID.id).update(center.toJson());
  } 
  

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}
Future uploadLogo(XFile imgfile)async{
final path='service_center_logos/${imgfile.name}';
final file=File(imgfile.path);
 TaskSnapshot task=await  store.ref().child(path).putFile(file);
 String link=await task.ref.getDownloadURL();
 return link;
}
}
