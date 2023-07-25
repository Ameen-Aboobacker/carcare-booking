

import 'package:carcareuser/app/model/user_profile_data_modle.dart';
import 'package:carcareuser/user_registrations/model/user_signup_model.dart';

class Success {
    UserProfileDataModel? userdata;
  UserSignupModel? data;
  String? response;
  Success({
this.data,
    this.response,
    this.userdata
  });
}

class Failure {

  dynamic errorResponse;
  Failure({
    this.errorResponse,
  });
}