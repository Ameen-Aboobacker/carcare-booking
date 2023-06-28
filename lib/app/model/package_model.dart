import 'package:cloud_firestore/cloud_firestore.dart';

class PackageModel {
  String? sid;
  String? id;
  String? userid;
  String? name;
  String? price;
  List? services;
  PackageModel({
    this.sid,
    required this.services,
    required this.name,
    this.id,
    this.userid,
    this.price,
  });

  factory PackageModel.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return PackageModel(
      name: data['name'],
      sid: data["sid"],
      services: data['services'],
      price:data['price'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "sid": sid,
      "id": id,
      "userId": userid,
      "name": name,
      'services': services,
      'price':price
    };
  }
}
