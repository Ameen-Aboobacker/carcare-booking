
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../app/model/booking_model.dart';
import '../../app/model/package_model.dart';
import '../../app/model/user_profile_data_modle.dart';
import '../../app/model/vehicle_model.dart';
import '../../utils/api_status.dart';

class FirebaseServices{
  FirebaseAuth auth=FirebaseAuth.instance;
  FirebaseFirestore db=FirebaseFirestore.instance;
  
  Future<UserProfileDataModel?> getUserData(String id) async {
    UserProfileDataModel? userData;
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await db.collection('user').doc(id).get();
      if (snapshot.exists) {
         userData = UserProfileDataModel.fromSnapshot(snapshot);
      
      }
    } catch (e) {
      log('Error fetching user data: $e');
    }

    return userData;
  }
  Future createPackages(String? id, PackageModel package) async {
     final path = db.collection('packages');
      final userpath = db.collection('user').doc(id);
    try {
      DocumentReference docId = await path.add(package.toMap());
    package.id = docId.id;
    await path.doc(docId.id).update(package.toMap());
    await userpath.update({'package':FieldValue.arrayUnion([docId.id]),});
    return Success();
    } catch (e) {
      Failure(errorResponse: e.toString());
    }
  }
  Future getPackages(String id,String sid)async {
     final snapshot = await db
        .collection('packages')
        .where('sid', isEqualTo: sid)
        .get();
    final packageList =
        snapshot.docs.map((e) => PackageModel.fromDocumentSnapshot(e)).toList();
    return packageList;
  }

  Future addCars(String id,Vehicle car)async{
    final userpath = db.collection('user').doc(id);
    final path=db.collection('cars');
  try {
      DocumentReference docId=await path.add(car.toMap());
    car.id=docId.id;
    await path.doc(docId.id).update(car.toMap());
    await userpath.update({'cars':FieldValue.arrayUnion([docId.id]),});
    return Success();
  } catch (e) {
    return Failure(errorResponse: e.toString());
  }
    
  }

  Future getCars(List<String> carIds) async{
    try {
         final path=db.collection('cars');
    final snapshot =
        await path.where(FieldPath.documentId,whereIn: carIds).get();
    final userData =
        snapshot.docs.map((e) => Vehicle.fromSnapshot(e)).toList();
        return Success(data: userData);
    } catch (e) {
      return Failure(errorResponse: e.toString());
    }
  }
  Future addBooking(Booking booking) async{
   final userpath = db.collection('user').doc(booking.userId);
    final centerpath= db.collection('service center').doc(booking.sId);
    final path=db.collection('bookings');
  try {
      DocumentReference docId=await path.add(booking.toMap());
    booking.id=docId.id;
    await path.doc(docId.id).update(booking.toMap());
    await userpath.update({'bookings':FieldValue.arrayUnion([docId.id]),});
     await centerpath.update({'booking':FieldValue.arrayUnion([docId.id]),});
    return Success(response: booking.id);
  } catch (e) {
    return Failure(errorResponse: e.toString());
  }
  }
  
  

}
