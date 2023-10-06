import 'dart:developer';

import 'package:carcareuser/app/model/package_model.dart';
import 'package:carcareuser/user_registrations/view_model/firebase_services.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import '../../utils/api_status.dart';
import '../../utils/constants.dart';
import '../model/service_model.dart';

class ServicesProvider with ChangeNotifier {
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseServices firebase = FirebaseServices();
  TextEditingController packageNameCtrl = TextEditingController();
  List<ServiceModel>? _services = [];

  List<ServiceModel>? get services => _services;
  final List<String> _selectedservices = [];

  List<String> get selectedservices => _selectedservices;
  Map<String, dynamic> _selectedoptions = {};
  Map<String, dynamic> get selectedOptions => _selectedoptions;
  List<PackageModel> _packages = [];
  List<PackageModel> get packages => _packages;
  int l = 0;

  PackageModel? selectedPackages;

  void toggleOption(ServiceModel service, bool value) {
    service.toggle(value);
    notifyListeners();
    log('${service.name}:${service.isSelected}');
  }

  getServices(List<String> serviceIds) async {
    final snapshot = await db
        .collection('services')
        .where(FieldPath.documentId, whereIn: serviceIds)
        .get();
    final servicess =
        snapshot.docs.map((e) => ServiceModel.fromSnapshot(e)).toList();
    _services = servicess;
    notifyListeners();
  }

  setSelectedServices(String value) {
    _selectedservices.add(value);
    notifyListeners();
  }

  removeSelectedServices(String value) {
    _selectedservices.remove(value);
    notifyListeners();
  }

  setPackages(PackageModel? package) {
    selectedPackages = package;

    log('hi:${package?.name}');
    notifyListeners();
  }

  getPackages(List<String> packages, String sid) async {
    final response = await firebase.getPackages(packages, sid);
    if (response != null) {
      _packages = response;
    }
     log('${packages}');

  }

  getSelectedOptions() {
    final selected = services!
        .where((service) => selectedservices.contains(service.id)).map((service) => service.name)
        .toList();
log(selected.toString());
    final totalrate = services!
        .where((service) => selectedservices.contains(service.id)).fold(0,
        (previousValue, service) => previousValue + int.parse(service.rate!));

    _selectedoptions = {'options': selected, 'rate': totalrate.toString()};
    log(_selectedoptions.toString());
  }

  PackageModel packageData() {
    return PackageModel(true,
        services: selectedOptions['options'],
        name: packageNameCtrl.text.trim(),
        price: selectedOptions['rate']);
  }

  createPackage(BuildContext context, serviceid) async {
    final navigator = Navigator.of(context);
    final String? id = await AccessToken.getAccessToken();
    final package = packageData();
    log(package.services!.length.toString());
    package.userid = id;
    package.sid = serviceid;
    final respone = await firebase.createPackages(id, package);
    log(respone.toString());
    if (respone is Success) {
      navigator.pop();
      navigator.pop();
    
     
    }
    if (respone is Failure) {
      log(respone.errorResponse.toString());
      navigator.pop();

      //await getPackages(serviceid);
    }

    notifyListeners();
  }
}
