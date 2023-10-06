import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagramclone/core/model/post_model.dart';
import 'package:instagramclone/core/model/users_model.dart';

class FireBaseServices {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('Users');
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> addUserToDatabase({
    required String uid,
    required UsersModel userModel,
  }) async {
    try {
      final Map<String, dynamic> userData = userModel.toMap();
      await users.doc(uid).set(userData);
      Get.snackbar("Success", "User Added");
    } catch (error) {
      Get.snackbar("Error", "Failed to add user: $error");
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

    try {
      await posts.doc(newId).set(postModel.convert2Map());
      Get.snackbar("Success", "Post Uploaded");
    } catch (e) {
      Get.snackbar("Error", "Failed to post: $e");
    }
  }

  Future<List<Map<String, dynamic>>> fetchDataFromFirebase() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('Posts').get();

      final List<Map<String, dynamic>> data = querySnapshot.docs
          .map((QueryDocumentSnapshot<Map<String, dynamic>> document) {
        return document.data();
      }).toList();

      return data;
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch data: $e");
      rethrow;
    }
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
      Get.snackbar("Error", "Failed to filter posts: $e");
      rethrow;
    }
  }

  Future<void> updateFollowersAndFollowing(
      String currentUserUid, String otherUserUid, bool showFollow) async {
    try {
      if (showFollow) {
        await _firebaseFirestore.collection("Users").doc(otherUserUid).update({
          "followers": FieldValue.arrayUnion([currentUserUid]),
        });
        await _firebaseFirestore
            .collection("Users")
            .doc(currentUserUid)
            .update({
          "followers": FieldValue.arrayUnion([otherUserUid]),
        });
      } else {
        await _firebaseFirestore.collection("Users").doc(otherUserUid).update({
          "followers": FieldValue.arrayRemove([currentUserUid]),
        });
        await _firebaseFirestore
            .collection("Users")
            .doc(currentUserUid)
            .update({
          "followers": FieldValue.arrayRemove([otherUserUid]),
        });
      }
      Get.snackbar("Success", "Followers and following updated successfully");
    } catch (e) {
      Get.snackbar("Error", "Failed to update followers and following: $e");
    }
  }

  Future<UsersModel> getUserDetails() async {
    try {
      DocumentSnapshot snap = await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      return UsersModel.fromMap(snap.data() as Map<String, dynamic>);
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch user data: $e");
      rethrow;
    }
  }
}
