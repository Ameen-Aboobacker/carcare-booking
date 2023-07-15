import '../app/model/vehicle_model.dart';

class Success {
  List<Vehicle>? data;
  String? response;
  Success({
    this.response,
    this.data,
  });
}

class Failure {
  int? code;
  String? errorResponse;
  Failure({
    this.code,
    this.errorResponse,
  });
}



