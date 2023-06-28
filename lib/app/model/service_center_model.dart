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
      'Email': email,
      'Name': name,
      'Contact': contact,
      'Place': place,
      'District': district,
      'Description': description,   
    };
  }

  factory ServiceCenter.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
     List? servicesData = data['Services'];
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
      name: data["Name"],
      email: data['Mail'],
      contact: data['Contact'],
      district: data["District"],
      place: data["Place"],
        description: data["Description"],
        image:data['ImagePath'],
        services: serviceList,
    );
  }
}
