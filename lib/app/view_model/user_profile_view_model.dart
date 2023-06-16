import 'package:carcareuser/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../../utils/routes/navigations.dart';
import '../../utils/session_controller.dart.dart';
import 'bottom_nav_view_model.dart';

class UserProfileViewModel with ChangeNotifier {
  UserProfileViewModel() {
    setUserProfileData();
   
  }

  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  Map? _userProfileData;
  bool _isLoading = false;

  Map? get userProfileData => _userProfileData;
  bool get isLoading => _isLoading;

  setUserProfileData() async {
    final user = auth.currentUser;
    final id = await AccessToken.getAccessToken();
    print(id);
    if (user != null) {
      _userProfileData = {'name': user.displayName, 'email': user.email};
    } else if (id != null) {
      print('id:$id');
      _userProfileData = {'name': id, 'email': id};
    }
     notifyListeners();
  }

  setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
  void signOut(BuildContext context) {
    auth.signOut().then((value) {
      AccessToken.clearAccessToken();
      GoogleSignIn().disconnect();
      Navigator.of(context).popAndPushNamed(
          NavigatorClass.loginScreen);
      Provider.of<BottomBarViewModel>(context, listen: false)
          .changeBottomNavindex(0);
    });
    notifyListeners();
  }
}
