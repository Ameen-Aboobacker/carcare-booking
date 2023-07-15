import 'package:firebase_auth/firebase_auth.dart';

class Success {

  String? response;
  Success({

    this.response,
  });
}

class Failure {

  dynamic errorResponse;
  Failure({
    this.errorResponse,
  });
}