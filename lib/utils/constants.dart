import 'package:shared_preferences/shared_preferences.dart';



class AccessToken {
  static Future<String?> getAccessToken() async {
    final sharedPref = await SharedPreferences.getInstance();
    final accessToken = sharedPref.getString('id');
    return accessToken;

  }

  static  clearAccessToken() async {
    final status = await SharedPreferences.getInstance();
   status.clear();
}
}

