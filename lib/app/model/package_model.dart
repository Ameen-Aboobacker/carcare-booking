import 'package:cloud_firestore/cloud_firestore.dart';

class PackageModel {
  String? sid;
  String? id;
  String? userid;
  String? name;
  String? price;
  List? services;
  bool isSelected;

  PackageModel(
    this.isSelected,
    {
    this.sid,
    required this.services,
    required this.name,
    this.id,
    this.userid,
    this.price,
    
  });
@override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PackageModel && other.name == name && other.price == price;
  }

  @override
  int get hashCode => name.hashCode ^ price.hashCode;
  factory PackageModel.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return PackageModel(true,
      name: data['name'],
      sid: data["sid"],
      services: data['services'],
      price:data['price'],
      id:data['id'],
      userid: data['userId'],
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
  void toggle(){
    isSelected=!isSelected;
  }
}
