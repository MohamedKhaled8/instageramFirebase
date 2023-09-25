import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagramclone/core/model/users_model.dart';

class FireBaseServices {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('Users');

  Future<void> addUserToDatabase({
    required String uid,
    required UsersModel userModel,
  }) async {
    try {
      final Map<String, dynamic> userData = userModel.toMap();
      await users.doc(uid).set(userData);
      print("User Added");
    } catch (error) {
      print("Failed to add user: $error");
      throw error;
    }
  }

}
