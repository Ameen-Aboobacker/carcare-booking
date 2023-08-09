

import 'package:carcareuser/app/model/user_profile_data_modle.dart';

class Success {
    UserProfileDataModel? userdata;
  UserProfileDataModel? data;
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