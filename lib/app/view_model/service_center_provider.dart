import 'dart:developer';

import 'package:carcareuser/app/view_model/services_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../model/service_center_model.dart';

class ServiceCenterProvider with ChangeNotifier {
  
  ServiceCenterProvider() {
    getServiceCenterList();
  }

  String _selected='services';
  List<ServiceCenter> _serviceCenterList = [];
  FirebaseFirestore db = FirebaseFirestore.instance;
late ServiceCenter _serviceCenter;
  bool _isLoading = false;

  ServiceCenter get serviceCenter => _serviceCenter;
  bool get isLoading => _isLoading;
  String get selected=>_selected;
  Position? _currentPosition;
  bool _isVenueListLoading = false;

  List<ServiceCenter> get serviceCenterList => _serviceCenterList;
  Position? get currentPosition => _currentPosition;
  bool get isVenueListLoading => _isVenueListLoading;
  setSelected(String value){
    _selected=value;
    notifyListeners();
  }

  getServiceCenterList() async {
    setVenueListLoading(true);
    final snapshot = await db.collection('service center').get();
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

  getSingleCenter(String id) async {
    setLoading(true);
    final snapshot =
        await db.collection('service center').where('sid', isEqualTo: id).get();
    final centerData =
        snapshot.docs.map((e) => ServiceCenter.fromSnapshot(e)).single;
    _serviceCenter = centerData;
    notifyListeners();
    setLoading(false);
  }


  setServiceCenter(ServiceCenter serviceCenter) async {
    _serviceCenter = serviceCenter;
    notifyListeners();
  }

  setLoading(bool loading) {
    _isLoading = loading;
  }

  setVenueListLoading(bool loading) {
    _isVenueListLoading = loading;
  }
}
