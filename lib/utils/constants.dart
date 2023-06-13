import 'package:shared_preferences/shared_preferences.dart';
import 'keys.dart';



class AccessToken {
  static Future<String?> getAccessToken() async {
    final sharedPref = await SharedPreferences.getInstance();
    final accessToken = sharedPref.getString(GlobalKeys.accesToken);
    return accessToken;
  }
}

class InvalidRespons {
  static const kUSERINVALIDRESPONSE = 100;
  static const kNOINTERNET = 101;
  static const kINVALIDFORMAT = 102;
  static const kUNKNOWNERROR = 103;
  static const kTIMEOUT = 104;
}
