import 'package:carcareuser/app/model/user_profile_data_modle.dart';
import 'package:carcareuser/user_registrations/view_model/firebase_services.dart';
import 'package:carcareuser/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import '../../user_registrations/components/snackbar.dart';
import '../../utils/routes/navigations.dart';
import 'bottom_nav_provider.dart';

class UserProfileProvider with ChangeNotifier {
  UserProfileProvider() {
    getUserProfileData();
  }
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController mailCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();

  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseServices firebase = FirebaseServices();

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

  getUserProfileData() async {
    // setLoading(true);
    final id = await AccessToken.getAccessToken();
    final data = await firebase.getUserData(id!);
    _userProfileData = data;
    //setLoading(false);
    notifyListeners();
  }

  setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void signOut(BuildContext context) {
    FirebaseAuth.instance.signOut().then((value) {
      AccessToken.clearAccessToken();
      GoogleSignIn().disconnect();
      Navigator.of(context).popAndPushNamed(NavigatorClass.loginScreen);
      Provider.of<BottomBarProvider>(context, listen: false)
          .changeBottomNavindex(0);
      notifyListeners();
    });
    notifyListeners();
  }
}
