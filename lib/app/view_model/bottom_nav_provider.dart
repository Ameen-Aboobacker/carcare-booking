
import 'package:carcareuser/app/model/user_profile_data_modle.dart';
import 'package:carcareuser/user_registrations/model/status.dart';
import 'package:carcareuser/utils/routes/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomBarProvider with ChangeNotifier {
  String? _user;
  String? get user =>_user;
  int _bottomBarIndex = 0;
   UserProvider usr =UserProvider();
  int get newIndex => _bottomBarIndex;
  UserProfileDataModel? _userdata;
  UserProfileDataModel? get userData=>_userdata;

  bottomOnChanged(int index) {
    _bottomBarIndex = index;
    notifyListeners();
  }

  changeBottomNavindex(int changIndex) {
    _bottomBarIndex = changIndex;
    notifyListeners();
  }

  getUser() async{
    SharedPreferences status=await SharedPreferences.getInstance();
    final id=status.getString('id');
    final result= await usr.getUserData(id);
    if(result is Success){
    _userdata=result.userdata;
    }
     notifyListeners();
  }
  
}