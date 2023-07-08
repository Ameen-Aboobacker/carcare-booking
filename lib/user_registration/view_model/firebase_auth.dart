
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../utils/api_status.dart';

class FirebaseServices{
  FirebaseAuth auth=FirebaseAuth.instance;
  FirebaseFirestore db=FirebaseFirestore.instance;
  Future createPackages(String? id, package) async {
     final path = db.collection('user').doc(id).collection('packages');
    try {
      DocumentReference docId = await path.add(package.toMap());
    package.id = docId.id;
    await path.doc(docId.id).update(package.toMap());
    return Success();
    } catch (e) {
      Failure(errorResponse: e);
    }
  }
}
