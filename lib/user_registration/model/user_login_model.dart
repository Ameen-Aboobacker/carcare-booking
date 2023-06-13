import 'dart:convert';

UserLoginModel userLoginModelFromJson(String str) =>
    UserLoginModel.fromJson(json.decode(str));

String userLoginModelToJson(UserLoginModel data) => json.encode(data.toJson());

class UserLoginModel {
  UserLoginModel({
    this.name,
    this.accessToken,
    this.email,
    this.password,
  });
  String? name;
  String? accessToken;
  String? email;
  String? password;

  factory UserLoginModel.fromJson(Map<String, dynamic> json) => UserLoginModel(
        name: json["name"],
        accessToken: json["accessToken"],
        email: json["mobile"],
      );

  Map<String, dynamic> toJson() => {
        "mail": email,
        "password": password,
      };
}
