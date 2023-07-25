import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfileDataModel {
  UserProfileDataModel({
    this.id,
    this.name,
    this.mobile,
    this.email,
    this.password,
    this.cars,
    this.packages,
    this.bookings,
  });

  String? id;
  String? name;
  String? mobile;
  String? email;
  String? password;
  List<String>? cars;
  List<String>? packages;
  List<String>? bookings;

  factory UserProfileDataModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    List? se = data['cars'];
    final ses = se?.map((e) => e.toString()).toList();
    List? packageData = data['packages'];
    final packages = packageData?.map((e) => e.toString()).toList();
    List? bookData = data['bookings'];
    final bookings = bookData?.map((e) => e.toString()).toList();
    return UserProfileDataModel(
      id: data["id"],
      mobile: data['mobile'],
      name: data["name"],
      email: data["email"],
      password: data['password'],
      cars: ses,
      packages: packages,
      bookings: bookings,
    );
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
