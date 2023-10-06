import 'dart:developer';

import 'package:carcareuser/app/model/user_profile_data_modle.dart';
import 'package:carcareuser/app/view_model/bottom_nav_provider.dart';
import 'package:carcareuser/user_registrations/model/status.dart';
import 'package:carcareuser/user_registrations/view_model/firebase_services.dart';
import 'package:carcareuser/utils/constants.dart';
import 'package:carcareuser/utils/routes/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../user_registrations/components/snackbar.dart';
import '../../utils/routes/navigations.dart';


class UserProfileProvider with ChangeNotifier {
  UserProfileProvider() {
    getUserData();
  }
  
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController mailCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();

  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseServices firebase = FirebaseServices();

  UserProvider userProvider=UserProvider();

  UserProfileDataModel setData() {
    return UserProfileDataModel(
      mobile: phoneCtrl.text,
      name: nameCtrl.text,
    );
  }

  updateData(BuildContext context) async {
    SnackBarWidget snackbar = SnackBarWidget(context);
    final navigator = Navigator.of(context);
    final id = await AccessToken.getAccessToken();
    final profileData = setData();
    profileData.id = id;
    await db.collection('user').doc(id).set(profileData.toJson()).then((value) {
      snackbar.snackBar(message: 'User Details Updated');
      navigator.pop();
      notifyListeners();
    });
    notifyListeners();
  }

  final auth = FirebaseAuth.instance;
  UserProfileDataModel? _userProfileData;

  bool _isLoading = false;

  UserProfileDataModel? get userProfileData => _userProfileData;
  bool get isLoading => _isLoading;

  setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

   getUserData() async{
    SharedPreferences status=await SharedPreferences.getInstance();
    final id=status.getString('id');
    final result= await userProvider.getUserData(id);

    if(result is Success){
    _userProfileData=result.userdata;
     
    }

     notifyListeners();
  }
  signOut(BuildContext context)async{
    final navb=Provider.of<BottomBarProvider>(context,listen: false);
    final nav=Navigator.of(context);
   await userProvider.signOut();
   _userProfileData=null;
   nav.popAndPushNamed(NavigatorClass.loginScreen);
   navb.bottomOnChanged(0);
   notifyListeners();
  }
 
}
