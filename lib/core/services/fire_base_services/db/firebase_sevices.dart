import 'package:uuid/uuid.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagramclone/core/model/post_model.dart';
import 'package:instagramclone/core/model/users_model.dart';
// ignore_for_file: avoid_print


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
      // ignore: avoid_print
      print("User Added");
    } catch (error) {
      // ignore: avoid_print
      print("Failed to add user: $error");

      // ignore: use_rethrow_when_possible
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

  Future<Map<String, dynamic>> filterPostUser(String uiddd) async {
    try {
      final uid = uiddd;
      final querySnapshot = await FirebaseFirestore.instance
          .collection("Posts")
          .where("uid", isEqualTo: uid)
          .get();
      final filterPostList = querySnapshot.docs;
      final postCount = filterPostList.length;

      return {
        "filterPostList": filterPostList,
        "postCount": postCount,
      };
    } catch (e) {
      // ignore: use_rethrow_when_possible
      throw e;
    }
  }
   final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> updateFollowersAndFollowing(
      String currentUserUid, String otherUserUid, bool showFollow) async {
    try {
      if (showFollow) {
        // إذا كان showFollow يساوي true، استخدم arrayUnion
        await _firebaseFirestore.collection("Users").doc(otherUserUid).update({
          "followers": FieldValue.arrayUnion([currentUserUid]),
        });
        await _firebaseFirestore.collection("Users").doc(currentUserUid).update({
          "followers": FieldValue.arrayUnion([otherUserUid]),
        });
      } else {
        // إذا كان showFollow يساوي false، استخدم arrayRemove
        await _firebaseFirestore.collection("Users").doc(otherUserUid).update({
          "followers": FieldValue.arrayRemove([currentUserUid]),
        });
        await _firebaseFirestore.collection("Users").doc(currentUserUid).update({
          "followers": FieldValue.arrayRemove([otherUserUid]),
        });
      }
    } catch (e) {
      print("Error updating followers and following: $e");
      throw e;
    }
  }
}
