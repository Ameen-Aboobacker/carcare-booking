import 'dart:developer';

import 'package:carcareuser/app/model/vehicle_model.dart';
import 'package:carcareuser/user_registration/components/snackbar.dart';
import 'package:carcareuser/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VehicleScreenModel extends ChangeNotifier {
  VehicleScreenModel(){
     getVehicleData();
  }
   TextEditingController modelCtrl = TextEditingController();
   TextEditingController brandCtrl = TextEditingController();
   TextEditingController numberCtrl = TextEditingController();
   TextEditingController yearCtrl = TextEditingController();
  
  bool _isLoading = false;
  List<Vehicle>? _vehicleData;
  bool get isLoading => _isLoading;
  final db = FirebaseFirestore.instance;
   List<Vehicle>? get vehicleData => _vehicleData ;
   

  Vehicle setvehicle() {
    final vehicle = Vehicle(
      brand: brandCtrl.text.trim(),
      model: modelCtrl.text.trim(),
      number: numberCtrl.text.trim(),
      year: yearCtrl.text.trim(),
    );
    return vehicle;
  }
  
   deleteCar(String docid)async {
    log(docid);
    final String? id =await AccessToken.getAccessToken();
       final path=db.collection('user').doc(id).collection('cars');
       await path.doc(docid).delete();
       await getVehicleData();
       notifyListeners();
   }
    getVehicleData() async {
      final String? id =await AccessToken.getAccessToken();
       final path=db.collection('user').doc(id).collection('cars');
    final snapshot =
        await path.get();
    final userData =
        snapshot.docs.map((e) => Vehicle.fromSnapshot(e)).toList();
        _vehicleData=userData;
        
    notifyListeners();
  }

  void addVehicle(BuildContext context) async{
    setLoading(true);
     final navigator=Navigator.of(context);
    final String? id =await AccessToken.getAccessToken(); 
    final vehicle = setvehicle();
    final path=db.collection('user').doc(id).collection('cars');
    DocumentReference docId=await path.add(vehicle.toMap());
    vehicle.id=docId.id;
    await path.doc(docId.id).update(vehicle.toMap());
    navigator.pop();
    await getVehicleData();
    setLoading(false);
    clear();
    notifyListeners();
  }
  update(BuildContext context,String docID)async{
    setLoading(true);
     final navigator=Navigator.of(context);
    final String? id =await AccessToken.getAccessToken(); 
    final vehicle = setvehicle();
    vehicle.id=docID;
    final path=db.collection('user').doc(id).collection('cars');
    await path.doc(docID).update(vehicle.toMap()).then((value)async{
      SnackBarWidget.snackBar(context, 'hello');
     await getVehicleData();
      navigator.pop();
    setLoading(false);
    
    clear();
    
   
    });
    
    notifyListeners();

    
  }
  setLoading(bool loading) async {
    _isLoading = loading;
    notifyListeners();
  }

  clear() {
    modelCtrl.clear();
    brandCtrl.clear();
    numberCtrl.clear();
    yearCtrl.clear();
    notifyListeners();
  }
}
