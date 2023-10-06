import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagramclone/core/model/users_model.dart';
import 'package:instagramclone/core/services/fire_base_services/db/firebase_sevices.dart';

abstract class CommentController extends GetxController {
  Future<void> loadComments(String postId);
  Future<void> uploadComment({
    required String commentText,
    required String postId,
    required String profileImg,
    required String username,
    required String uid,
  });
  Future<void> refreshUser();
  clearTextCont();
}

class CommentControllerImp extends CommentController {
  List<QueryDocumentSnapshot> _comments = <QueryDocumentSnapshot>[];
  final TextEditingController commentController = TextEditingController();
  final FireBaseServices _fireBaseServices = FireBaseServices();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  UsersModel? _userData;
  UsersModel? get getUser => _userData;
  List<QueryDocumentSnapshot> get comments => _comments;
  set comments(List<QueryDocumentSnapshot> value) {
    _comments = value;
    update();
  }

  @override
  Future<void> onInit() async {
    await refreshUser();
    super.onInit();
  }

  @override
  Future<void> refreshUser() async {
    try {
      UsersModel userModel = await _fireBaseServices.getUserDetails();
      _userData = userModel;
      update();
    } catch (e) {
      Get.snackbar("Error", "Failed to load user details: $e");
    }
    update();
  }

  @override
  Future<void> loadComments(String postId) async {
    try {
      var querySnapshot = await _firebaseFirestore
          .collection('Posts')
          .doc(postId)
          .collection("Comments")
          .orderBy("dataPublished", descending: false)
          .get();

      comments.assignAll(querySnapshot.docs);
      update();
    } catch (e) {
      Get.snackbar("Error", "Failed to load comments: $e");
    }
  }

  @override
  Future<void> uploadComment({
    required String commentText,
    required String postId,
    required String profileImg,
    required String username,
    required String uid,
  }) async {
    try {
      if (commentText.isNotEmpty) {
        String commentId = const Uuid().v1();

        await _firebaseFirestore
            .collection("Posts")
            .doc(postId)
            .collection("Comments")
            .doc(commentId)
            .set({
          "profilePic": profileImg,
          "username": username,
          "textComment": commentText,
          "dataPublished": DateTime.now(),
          "uid": uid,
          "commentId": commentId
        });
        clearTextCont();
        Get.snackbar("Success", "Comment uploaded successfully");
      } else {
        Get.snackbar("Error", "Comment cannot be empty");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to upload comment: $e");
    }
  }

  @override
  clearTextCont() {
    commentController.clear();
    update();
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }
}
