import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:carcareuser/utils/constants.dart';

class CenterListViewModel with ChangeNotifier {
  CenterListViewModel() {
    getCenterListInfo();
  }
  List _centerDataList = [];
  bool _isCenterListLoading = false;

  List  get venuDataList => _centerDataList;

  bool get isCenterListLoading => _isCenterListLoading;

  getCenterListInfo() async {
    setCenterListLoading(true);
   
    setCenterListLoading(false);
  }

  setCenterListData(List centerDataList) async {
    _centerDataList = centerDataList;
    notifyListeners();
  }

  setCenterListLoading(bool loading) {
    _isCenterListLoading = loading;
  }


}
