// To parse this JSON data, do
//
//     final userProfileDataModle = userProfileDataModleFromJson(jsonString);

import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfileDataModel {
  UserProfileDataModel({
    this.id,
    this.name,
    this.mobile,
    this.email,
    this.password,
  });

  String? id;
  String? name;
  String? mobile;
   String? email;
  String? password;


  factory UserProfileDataModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return UserProfileDataModel(
      id: data["id"],
      mobile: data['mobile'],
      name: data["name"],
       email: data["email"],
      password: data['password'],
     
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "mobile": mobile,
        "email": email,
        
      };

      bool isEmpty(){
        if(id==null||name==null||mobile==null){
          return true;
        }
        return false;
      }
}
