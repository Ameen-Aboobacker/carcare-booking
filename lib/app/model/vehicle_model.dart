import 'package:cloud_firestore/cloud_firestore.dart';

class Vehicle {
   String? id;
  final String? brand;
  final String? model;
  final String? number;
  final String? year;

  Vehicle(
      { this.id, 
        required this.brand,
      required this.model,
      required this.number,
      required this.year});
  toMap() {
    return {
      'id':id,
      'Brand': brand,
      'Model': model,
      'Number': number,
      'Year': year,
    };
  }

  factory Vehicle.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> document) {
    final data = document.data()!;
    return Vehicle(
      id:data['id'],
      brand: data["Brand"],
      model: data['Model'],
      number: data['Number'],
      year: data["Year"],
    );
  }
   
}
