import 'package:carcareuser/app/model/vehicle_model.dart';
import 'package:flutter/material.dart';

class VehicleScreenModel extends ChangeNotifier {
  final TextEditingController modelCtrl = TextEditingController();
  final TextEditingController brandCtrl = TextEditingController();
  final TextEditingController numberCtrl = TextEditingController();
  final TextEditingController yearCtrl = TextEditingController();
   bool _isLoading=false;
 bool get isLoading => _isLoading;
  final List car=[];

  Vehicle setvehicle() {
    final vehicle = Vehicle(
      brand: brandCtrl.text.trim(),
      model: modelCtrl.text.trim(),
      number: numberCtrl.text.trim(),
      year: yearCtrl.text.trim(),
    );
     return vehicle;
  }
  void addVehicle(BuildContext context){
    setLoading(true);
  final  vehicle=setvehicle();
  car.add(vehicle);
  Navigator.of(context).pop();
  setLoading(false);
  clear();
  notifyListeners();

}
  setLoading(bool loading) async {
    _isLoading = loading;
    notifyListeners();
  }

  clear(){
    modelCtrl.clear();
    brandCtrl.clear();
    numberCtrl.clear();
    yearCtrl.clear();
    notifyListeners();
  }
}


