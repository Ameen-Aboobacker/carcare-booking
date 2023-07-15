import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceModel {
  String? id;
  final String? name;
  final String? rate;
  bool isSelected;

  ServiceModel({
    this.id,
    this.name,
    this.rate,
    this.isSelected=false,}
  );

  factory ServiceModel.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> snapshot){
   final data=snapshot.data()!;
   return ServiceModel(name:data['name'], rate:data['rate']);
  }
  void toggle() {
  isSelected = !isSelected;
}
toMap(){
  return{
    "id":id,
    'name':name,
    'rate':rate,
  };
}
}