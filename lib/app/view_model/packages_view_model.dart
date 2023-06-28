

import 'package:carcareuser/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/package_model.dart';

class PackagesViewModel extends ChangeNotifier{
 FirebaseFirestore db=FirebaseFirestore.instance; 
 List<PackageModel>? _packages;

  List<PackageModel>? get  packages =>_packages;
  
  bool selected=false;
 
 

  


  getPackages(String sid)async{
    final id=await AccessToken.getAccessToken();
    final snapshot=await db.collection('user').doc(id).collection('packages').where('sid',isEqualTo:sid ).get();
    final packageList=snapshot.docs.map((e) => PackageModel.fromDocumentSnapshot(e)).toList();
    _packages=packageList;
    notifyListeners();
  }
 


}