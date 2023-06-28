import 'package:cloud_firestore/cloud_firestore.dart';

class FirebasePaths{
 static DocumentReference userpath(String id){
     return FirebaseFirestore.instance.collection('user').doc(id);
 }
     
}