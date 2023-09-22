
import 'package:cloud_firestore/cloud_firestore.dart';


class ServiceCenter {
  String? name;
  String? email;
  String? contact;
  String? place;
  String? district;
  String? id;
  String? description;
  String? image;
   List<String>? service;

  ServiceCenter({
    this.id,
    required this.name,
    required this.email,
    required this.contact,
    required this.place,
    required this.district,
    required this.description,
    this.service,
    this.image,
  });
  toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'contact': contact,
      'place': place,
      'district': district,
      'description': description,
    };
  }

  factory ServiceCenter.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    List? se=data['service'];
     final ses=se?.map((e) => e.toString()).toList();
    return ServiceCenter(
      id: data['sid'],
      name: data["name"],
      email: data['mail'],
      contact: data['contact'],
      district: data["district"],
      place: data["Place"],
      description: data["description"],
      image: data['imagePath'],
      service:ses,
    );
  }
}
