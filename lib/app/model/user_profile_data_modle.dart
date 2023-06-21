// To parse this JSON data, do
//
//     final userProfileDataModle = userProfileDataModleFromJson(jsonString);

import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfileDataModel {
  UserProfileDataModel({
    this.id,
    this.name,
    this.mobile,
    this.password,
    this.vehicle,
  });

  String? id;
  String? name;
  String? mobile;
  String? password;
  List? vehicle;

  factory UserProfileDataModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return UserProfileDataModel(
      id: data["id"],
      mobile: data['mobile'],
      name: data["name"],
      password: data['password'],
      vehicle: data["vehicle"],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "mobile": mobile,
        "password": password,
        "vehicle": vehicle,
      };
}
