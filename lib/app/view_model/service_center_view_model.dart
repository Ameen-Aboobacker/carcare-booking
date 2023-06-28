import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../model/package_model.dart';
import '../model/service_center_model.dart';




class ServiceCenterViewModel  with ChangeNotifier {
  ServiceCenterViewModel () {
    getServiceCenterList();
  }
  List<ServiceCenter> _serviceCenterList = [];
  FirebaseFirestore db=FirebaseFirestore.instance;

   PackageModel? selectedPackages;
  Position? _currentPosition;
  bool _isVenueListLoading = false;

  List<ServiceCenter> get serviceCenterList => _serviceCenterList;
  Position? get currentPosition => _currentPosition;
  bool get isVenueListLoading => _isVenueListLoading;

  getServiceCenterList() async {
    setVenueListLoading(true);
    final snapshot =
          await db.collection('service center').get();
      final centerData =
          snapshot.docs.map((e) => ServiceCenter.fromSnapshot(e)).toList();
      _serviceCenterList = centerData;
          notifyListeners();
    setVenueListLoading(false);
      
  
  }

  setVenueListData(List<ServiceCenter> serviceCenterList) async {
    _serviceCenterList = serviceCenterList;
    notifyListeners();
  }

  setVenueListLoading(bool loading) {
    _isVenueListLoading = loading;
  }

}