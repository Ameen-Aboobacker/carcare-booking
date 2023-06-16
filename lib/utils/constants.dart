import 'package:shared_preferences/shared_preferences.dart';
import 'keys.dart';



class AccessToken {
  static Future<String?> getAccessToken() async {
    final sharedPref = await SharedPreferences.getInstance();
    final accessToken = sharedPref.getString(GlobalKeys.accesToken);
    return accessToken;

  }

  static  clearAccessToken() async {
    final status = await SharedPreferences.getInstance();
   status.clear();
}
}

