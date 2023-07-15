import 'dart:developer';

import 'package:carcareuser/app/model/user_profile_data_modle.dart';
import 'package:carcareuser/user_registrations/model/user_login_model.dart';
import 'package:carcareuser/user_registrations/model/user_signup_model.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../app/model/service_center_model.dart';
import '../../user_registrations/model/status.dart';

enum AuthStatus {
  uninitialized,
  authenticated,
  authenticating,
  unauthenticated
}

class UserProvider with ChangeNotifier{
  UserProfileDataModel? _serviceCenter;
  UserProfileDataModel? get serviceCenter => _serviceCenter;
  late FirebaseAuth _auth;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? _user;
  AuthStatus _status = AuthStatus.uninitialized;
  ServiceCenter? se;

  UserProvider() {
    _auth = FirebaseAuth.instance;
    _auth.authStateChanges().listen(_onAuthStateChanged);
  }

  AuthStatus get status => _status;
  User? get user => _user;

  Future signUp(UserSignupModel userData, BuildContext context) async {
    try {
      _status = AuthStatus.authenticating;
      notifyListeners();
      final userCredential = await _auth.createUserWithEmailAndPassword(
          email: userData.email!, password: userData.password!);

      _user = userCredential.user;
      userData.id = _user!.uid;

      await _firestore
          .collection('users')
          .doc(_user!.uid)
          .set(userData.toJson());

      _status = AuthStatus.authenticated;
      return Success();
    } on FirebaseAuthException catch (e) {
      _status = AuthStatus.unauthenticated;
      return Failure(errorResponse: e);
    } finally {
      notifyListeners();
    }
  }

  Future login(UserLoginModel loginData) async {
    try {
      _status = AuthStatus.authenticating;
      notifyListeners();
      final res = await _auth.signInWithEmailAndPassword(
          email: loginData.email!, password: loginData.password!);
      _status = AuthStatus.authenticated;
      await getUserData();
      log(_serviceCenter!.id.toString());
      return Success(response: res.user!.uid);
    } on FirebaseAuthException catch (e) {
      _status = AuthStatus.unauthenticated;
      return Failure(errorResponse: e);
    } finally {
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    _status = AuthStatus.unauthenticated;
    notifyListeners();
  }

  void _onAuthStateChanged(User? user) {
    _user = user;
    _status =
        user != null ? AuthStatus.authenticated : AuthStatus.unauthenticated;
    notifyListeners();
  }

  Future<UserProfileDataModel?> getUserData() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection('user').doc(_user!.uid).get();
      if (snapshot.exists) {
        _serviceCenter = UserProfileDataModel.fromSnapshot(snapshot);
        notifyListeners();
      }
    } catch (e) {
      log('Error fetching user data: $e');
    }

    return _serviceCenter;
  }

  /*addService(Services service) async {
    final servicesCollection =
        FirebaseFirestore.instance.collection('Services');
    final serviceCenterCollection =
        FirebaseFirestore.instance.collection('users');

    // Add the service to the Services collection
    try {
      final ref = await servicesCollection.add(service.toMap());
      service.id = ref.id;
      servicesCollection.doc(service.id).set(service.toMap());
      log(_user!.uid);
      log(service.id!);
      // Update the serviceIds field in the ServiceCenter collection
      serviceCenterCollection.doc(_user!.uid).update({
        'services': FieldValue.arrayUnion([service.id]),
      });
        await getServicesForServiceCenter();
      return Success();
    } catch (e) {
      log(e.toString());
      return Failure(errorResponse: e);
    } finally {
      notifyListeners();
    }
  }*/

  /*Future<List<Services>> getServicesForServiceCenter() async {
  final servicesCollection = FirebaseFirestore.instance.collection('Services');

  final serviceIds = _serviceCenter!.services;
   const  chunkSize = 10;
  final serviceList = <Services>[];

  for (var i = 0; i < serviceIds!.length; i += chunkSize) {
    final chunkIds = serviceIds.sublist(i, i + chunkSize);

    final querySnapshot = await servicesCollection.where('id', whereIn: chunkIds).get();

    final services = querySnapshot.docs.map((doc) {
      final data = doc.data();
      return Services(
        id: doc.id,
        name: data['name'],
      );
    }).toList();

    serviceList.addAll(services);
  }
  log(serviceList.toString());
  return serviceList;
}*/
}
