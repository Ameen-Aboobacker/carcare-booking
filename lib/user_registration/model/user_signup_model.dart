// To parse this JSON data, do
//
//     final userSignupModel = userSignupModelFromJson(jsonString);

import 'dart:convert';
String userSignupModelToJson(UserSignupModel data) =>
    json.encode(data.toJson());

class UserSignupModel {
  UserSignupModel({
    this.name,
    this.mobile,
    this.email,
    this.password,
    this.accessToken,
    this.id,
  });

  String? name;
  String? mobile;
  String? email;
  String? password;
  String? id;
  String? accessToken;

fromJson(Map<String, dynamic> json) =>
      UserSignupModel(
        name: json["name"],
        mobile: json["mobile"],
        password: json["password"],
        accessToken: json["accessToken"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "mobile": mobile,
        "password": password,
        "id":id,
      };
}
