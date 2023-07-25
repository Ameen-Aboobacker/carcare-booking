//import 'dart:developer';

//import 'package:carcareuser/app/model/user_profile_data_modle.dart';
import 'dart:developer';

import 'package:carcareuser/user_registrations/model/user_login_model.dart';
import 'package:carcareuser/user_registrations/model/user_signup_model.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

//import '../../app/model/service_center_model.dart';
import '../../app/model/user_profile_data_modle.dart';
import '../../user_registrations/model/status.dart';


enum AuthStatus {
  uninitialized,
  authenticated,
  authenticating,
  unauthenticated
}

class UserProvider with ChangeNotifier {
  //UserProfileDataModel? _serviceCenter;
  //UserProfileDataModel? get serviceCenter => _serviceCenter;
  final  FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? _user;
  AuthStatus _status = AuthStatus.uninitialized;
  AuthStatus get status => _status;
  User? get user => _user;

  Future signUp(UserSignupModel userData) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
          email: userData.email!, password: userData.password!);

      _user = userCredential.user;
      userData.id = _user!.uid;

     await _firestore
          .collection('user')
          .doc(_user!.uid)
          .set(userData.toJson());
      return Success(data: userData);
    } on FirebaseAuthException catch (e) {
      return Failure(errorResponse: e);
    } finally {
      notifyListeners();
    }
  }

  Future login(UserLoginModel loginData) async  {
    try {
      final res = await _auth.signInWithEmailAndPassword(
          email: loginData.email!, password: loginData.password!);
      return Success(response: res.user!.uid);
    } on FirebaseAuthException catch (e) {
      _status = AuthStatus.unauthenticated;
      return Failure(errorResponse: e);
    } finally {
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    SharedPreferences sh = await SharedPreferences.getInstance();
    sh.clear();
    _user = null;
    notifyListeners();
  }


 Future getUserData(String? id ) async {
  
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection('user').doc(id).get();
      if (snapshot.exists) {
      final  userData = UserProfileDataModel.fromSnapshot(snapshot);
          
     return  Success(userdata: userData);
       
      }
    

    
  }
}
