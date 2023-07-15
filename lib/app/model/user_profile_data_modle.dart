// To parse this JSON data, do
//
//     final userProfileDataModle = userProfileDataModleFromJson(jsonString);

import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfileDataModel {
  UserProfileDataModel(
      {this.id,
      this.name,
      this.mobile,
      this.email,
      this.password,
      this.cars,
      this.packages});

  String? id;
  String? name;
  String? mobile;
  String? email;
  String? password;
  List<String>? cars;
  List<String>? packages;

  factory UserProfileDataModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    List? se = data['cars'];
    final ses = se!.map((e) => e.toString()).toList();
    List? packageData = data['cars'];
    final packages = packageData!.map((e) => e.toString()).toList();
    return UserProfileDataModel(
        id: data["id"],
        mobile: data['mobile'],
        name: data["name"],
        email: data["email"],
        password: data['password'],
        cars: ses,
        packages: packages);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "mobile": mobile,
        "email": email,
      };

  bool isEmpty() {
    if (id == null || name == null || mobile == null) {
      return true;
    }
    return false;
  }
}
