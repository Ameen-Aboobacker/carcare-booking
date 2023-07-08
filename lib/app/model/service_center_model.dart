import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../view_model/services_view_model.dart';

class ServiceCenter {
  String? name;
  String? email;
  String? contact;
  String? place;
  String? district;
  String? id;
  String? description;
  String? image;
  final List<Option>? services;

  ServiceCenter({
    this.id,
    required this.name,
    required this.email,
    required this.contact,
    required this.place,
    required this.district,
    required this.description,
    this.services,
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
    List? servicesData = data['services'];
    List<Option>? serviceList;
    log(serviceList.toString());
    if (servicesData != null) {
      serviceList = servicesData.map((map) {
        return Option(
          map['name'],
          map['rate'],
          false,
        );
      }).toList();
    }
    return ServiceCenter(
      id: data['sid'],
      name: data["name"],
      email: data['mail'],
      contact: data['contact'],
      district: data["district"],
      place: data["place"],
      description: data["description"],
      image: data['imagePath'],
      services: serviceList,
    );
  }
}
