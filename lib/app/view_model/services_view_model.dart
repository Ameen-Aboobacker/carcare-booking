

import 'dart:developer';

import 'package:carcareuser/app/model/package_model.dart';
import 'package:carcareuser/app/view_model/center_list_view_model.dart';
import 'package:carcareuser/app/view_model/packages_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';
import '../model/service_center_model.dart';

class Option {
  final String name;
   final String rate;
  bool isSelected;

  Option(this.name,this.rate, this.isSelected, );
}




class ServicesViewModel with ChangeNotifier {
   
  FirebaseFirestore db=FirebaseFirestore.instance;

  TextEditingController packageNameCtrl=TextEditingController();
  List<Option>? _options=[];
  List<Option>? get options=>_options;
   Map<String,dynamic> _selectedoptions = {};

  Map<String,dynamic> get selectedOptions => _selectedoptions;
  setOptions(BuildContext context) {
 final ServiceCenter centerData = context.read<CenterDetailsViewModel>().serviceCenter;
 _options=centerData.services;
 log(_options.toString());
 
  }
 

  void toggleOption(int index) {
    options![index].isSelected = !options![index].isSelected;
    notifyListeners();
  }

  List<String> getSelectedOptions() {
    final selected= options!
        .where((option) => option.isSelected)
        .map((option) => option.name)
        .toList();

     final rateList=options!.where((option) => option.isSelected).map((e) => e.rate).toList(); 
     final total=sum(rateList);

     _selectedoptions={'options':selected,'rate':total}; 
     log(_selectedoptions.toString()); 
      
        return selected;
        
  }
  sum(List a){
    int sum=0;
   for (var element in a) {
     sum=int.parse(element)+sum;
  
   }
      print(sum);
     return sum.toString();
  }
    
   packageData(){
    return PackageModel(services: selectedOptions['options'], name: packageNameCtrl.text.trim(),price:selectedOptions['rate']);
  }
  createPackage(BuildContext context,serviceid)async {
   final navigator=Navigator.of(context);
   final packageProvider=Provider.of<PackagesViewModel>(context,listen:false);
    final String? id =await AccessToken.getAccessToken(); 
    final package = packageData();
    package.userid=id;
    package.sid=serviceid;
    final path=db.collection('user').doc(id).collection('packages');
    DocumentReference docId=await path.add(package.toMap());
    package.id=docId.id;
    await path.doc(docId.id).update(package.toMap());
    navigator.pop();
    await packageProvider.getPackages(serviceid);
  
    notifyListeners();

}
}