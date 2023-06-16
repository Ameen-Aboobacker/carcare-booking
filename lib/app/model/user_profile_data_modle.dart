// To parse this JSON data, do
//
//     final userProfileDataModle = userProfileDataModleFromJson(jsonString);

import 'dart:convert';

UserProfileDataModle userProfileDataModleFromJson(String str) => UserProfileDataModle.fromJson(json.decode(str));

String userProfileDataModleToJson(UserProfileDataModle data) => json.encode(data.toJson());

class UserProfileDataModle {
    UserProfileDataModle({
        this.id,
        this.name,
        this.mobile,
        this.password,
        this.wallet,
        this.blockStatus,
        this.v,
    });

    String? id;
    String? name;
    String? mobile;
    String? password;
    int? wallet;
    bool? blockStatus;
    int? v;

    factory UserProfileDataModle.fromJson(Map<String, dynamic> json) => UserProfileDataModle(
        id: json["_id"],
        name: json["name"],
        mobile: json["mobile"],
        password: json["password"],
        wallet: json["wallet"],
        blockStatus: json["blockStatus"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "mobile": mobile,
        "password": password,
        "wallet": wallet,
        "blockStatus": blockStatus,
        "__v": v,
    };
}
