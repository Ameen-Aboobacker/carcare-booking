import 'dart:developer';

import 'package:carcareuser/app/model/package_model.dart';
import 'package:carcareuser/user_registration/view_model/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import '../../utils/api_status.dart';
import '../../utils/constants.dart';

class Option {
  final String name;
  final String rate;
  bool isSelected;

  Option(
    this.name,
    this.rate,
    this.isSelected,
  );
}

class ServicesProvider with ChangeNotifier {
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseServices firebase = FirebaseServices();
  TextEditingController packageNameCtrl = TextEditingController();
  List<Option>? _options = [];
  List<Option>? get options => _options;
  Map<String, dynamic> _selectedoptions = {};

  Map<String, dynamic> get selectedOptions => _selectedoptions;

  List<PackageModel>? _packages;

  List<PackageModel>? get packages => _packages;

  bool selected = false;

  setOptions(BuildContext context, List<Option>? centerData) {
    _options = centerData;
    log(_options.toString());
  }

  void toggleOption(int index) {
    options![index].isSelected = !options![index].isSelected;
    notifyListeners();
  }

  getPackages(String sid) async {
    final id = await AccessToken.getAccessToken();
    final snapshot = await db
        .collection('user')
        .doc(id)
        .collection('packages')
        .where('sid', isEqualTo: sid)
        .get();
    final packageList =
        snapshot.docs.map((e) => PackageModel.fromDocumentSnapshot(e)).toList();
    _packages = packageList;
    notifyListeners();
  }

  List<String> getSelectedOptions() {
    final selected = options!
        .where((option) => option.isSelected)
        .map((option) => option.name)
        .toList();

    final rateList = options!
        .where((option) => option.isSelected)
        .map((e) => e.rate)
        .toList();
    final total = sum(rateList);

    _selectedoptions = {'options': selected, 'rate': total};
    log(_selectedoptions.toString());

    return selected;
  }

  sum(List a) {
    int sum = 0;
    for (var element in a) {
      sum = int.parse(element) + sum;
    }
    print(sum);
    return sum.toString();
  }

  packageData() {
    return PackageModel(
        services: selectedOptions['options'],
        name: packageNameCtrl.text.trim(),
        price: selectedOptions['rate']);
  }

  createPackage(BuildContext context, serviceid) async {
    final navigator = Navigator.of(context);
    final String? id = await AccessToken.getAccessToken();
    final package = packageData();
    package.userid = id;
    package.sid = serviceid;
    final respone = await firebase.createPackages(id, package);
    if (respone is Success) {
      navigator.pop();
      await getPackages(serviceid);
    }
    if (respone is Failure) {
      navigator.pop();
      await getPackages(serviceid);
    }

    notifyListeners();
  }
}
