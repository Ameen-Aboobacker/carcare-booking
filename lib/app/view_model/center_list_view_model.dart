
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';



import '../model/service_center_model.dart';

class CenterDetailsViewModel with ChangeNotifier {
   FirebaseFirestore db=FirebaseFirestore.instance;
  late ServiceCenter _serviceCenter;
  bool _isLoading = false;

  ServiceCenter get serviceCenter => _serviceCenter;
  bool get isLoading => _isLoading;


  getSingleVenue(String id) async {
    setLoading(true);
   final snapshot =
          await db.collection('service center').where('sid',isEqualTo: id).get();
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

}