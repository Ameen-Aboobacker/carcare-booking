import 'dart:developer';

import 'package:carcareuser/app/model/vehicle_model.dart';
import 'package:carcareuser/app/view_model/user_profile_provider.dart';
import 'package:carcareuser/user_registrations/components/snackbar.dart';
import 'package:carcareuser/user_registrations/view_model/firebase_services.dart';
import 'package:carcareuser/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../utils/api_status.dart';

class VehicleProvider extends ChangeNotifier {
   TextEditingController modelCtrl = TextEditingController();
   TextEditingController brandCtrl = TextEditingController();
   TextEditingController numberCtrl = TextEditingController();
   TextEditingController yearCtrl = TextEditingController();
  
  bool _isLoading = false;
  List<Vehicle>? _vehicleData;
  bool get isLoading => _isLoading;
  final db = FirebaseFirestore.instance;
   List<Vehicle>? get vehicleData => _vehicleData ;
   FirebaseServices firebase=FirebaseServices();
   Vehicle? selectedVehicle;
 

   selectCar(Vehicle? car){
   selectedVehicle=car;
   notifyListeners();
   }
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
       //await getVehicleData();
       notifyListeners();
   }
    getVehicleData(List<String> carIds) async {
     // final String? id =await AccessToken.getAccessToken();
    final response =await firebase.getCars(carIds);
        if(response is Success){
          _vehicleData=response.data;
        }
        
    notifyListeners();
  }

  void addVehicle(BuildContext context,UserProfileProvider user) async{
    setLoading(true);
     final navigator=Navigator.of(context);
    final String? id =await AccessToken.getAccessToken(); 
    final car = setvehicle();
    final response=await firebase.addCars(id!, car);
    navigator.pop();
    await user.getUserProfileData();
    final carids=user.userProfileData!.cars;
    await getVehicleData(carids!);
    setLoading(false);
    clear();
    notifyListeners();
  }
  update(BuildContext context,String docID)async{
     SnackBarWidget snackbar=SnackBarWidget(context);
    setLoading(true);
     final navigator=Navigator.of(context);
    final String? id =await AccessToken.getAccessToken(); 
    final vehicle = setvehicle();
    vehicle.id=docID;
    final path=db.collection('user').doc(id).collection('cars');
    await path.doc(docID).update(vehicle.toMap()).then((value)async{
      snackbar.snackBar(message:'hello');
    // await getVehicleData(ca);
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
