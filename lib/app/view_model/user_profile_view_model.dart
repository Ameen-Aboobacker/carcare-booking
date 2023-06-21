import 'dart:developer';

import 'package:carcareuser/app/model/user_profile_data_modle.dart';
import 'package:carcareuser/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../../utils/routes/navigations.dart';
import 'bottom_nav_view_model.dart';

class UserProfileViewModel with ChangeNotifier {
 UserProfileViewModel(){
  getUserProfileData();
 } 

  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  UserProfileDataModel? _userProfileData;

  bool _isLoading = false;
 
  UserProfileDataModel? get userProfileData => _userProfileData;
  bool get isLoading => _isLoading;

  getUserProfileData() async {
    final user = auth.currentUser;
     
   // final id = await AccessToken.getAccessToken();
   if(user!=null){
    final snapshot =
        await db.collection('user').where('id',isEqualTo: user.uid).get();
    final userData =
        snapshot.docs.map((e) => UserProfileDataModel.fromSnapshot(e)).single;
        _userProfileData=userData;
        log(userData.toJson().toString());
    notifyListeners();
  
   }
  }

  setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
  void signOut(BuildContext context) {
   FirebaseAuth.instance.currentUser!.delete().then((value) {
      AccessToken.clearAccessToken();
      GoogleSignIn().disconnect();
      Navigator.of(context).popAndPushNamed(
          NavigatorClass.loginScreen);
      Provider.of<BottomBarViewModel>(context, listen: false)
          .changeBottomNavindex(0);
          notifyListeners();
    });
    
  }
}
