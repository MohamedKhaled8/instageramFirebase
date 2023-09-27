import 'package:uuid/uuid.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagramclone/core/model/post_model.dart';
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

  Future<void> uploadPost({
    required description,
    required urlll,
    required profileImg,
    required username,
  }) async {
    CollectionReference posts = FirebaseFirestore.instance.collection('Posts');

    String newId = const Uuid().v1();

    PostData postModel = PostData(
        datePublished: DateTime.now(),
        description: description,
        imgPost: urlll,
        likes: [],
        profileImg: profileImg,
        postId: newId,
        uid: FirebaseAuth.instance.currentUser!.uid,
        username: username);

    posts
        .doc(newId)
        .set(postModel.convert2Map())
        .then((value) => print("done................"))
        .catchError((error) => print("Failed to post: $error"));
  }

  Future<List<Map<String, dynamic>>> fetchDataFromFirebase() async {
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('Posts').get();

    final List<Map<String, dynamic>> data = querySnapshot.docs
        .map((QueryDocumentSnapshot<Map<String, dynamic>> document) {
      return document.data();
    }).toList();

    return data;
  }
}
