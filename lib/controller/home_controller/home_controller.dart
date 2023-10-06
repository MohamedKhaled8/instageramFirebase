import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagramclone/core/services/fire_base_services/db/firebase_sevices.dart';

abstract class HomeController extends GetxController {
  void signOut();
  Future<void> fetchData();
  showmodel(BuildContext context, Map data);
  Future<void> onClickPic({required Map postData});
  Future<void> toggleLikes({required Map postData});
  void updateValues(bool isAnimating);
  Future<void> isisAnimating({required Map postData});
}

class HomeControllerImp extends HomeController {
  bool isLoading = true;
  bool hasError = false;
  final posts = List<Map<String, dynamic>>.empty().obs;
  int commentCount = 0;
  int pageSize = 10;
  int currentPage = 1;
  bool showHeart = false;
  bool isLikeAnimating = false;

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final String _auth = FirebaseAuth.instance.currentUser!.uid;
  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  @override
  void updateValues(
    bool isAnimating,
  ) {
    isLikeAnimating = isAnimating;

    update();
  }

  @override
  Future<void> onClickPic({required Map postData}) async {
    isLikeAnimating = true;
    try {
      await _firebaseFirestore
          .collection("Posts")
          .doc(postData["postId"])
          .update({
        "likes": FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid])
      });
    } catch (e) {
      Get.snackbar("Error", "Failed to like post: $e");
    }
    update();
  }

  @override
  Future<void> toggleLikes({required Map postData}) async {
    try {
      if (postData["likes"].contains(_auth)) {
        await _firebaseFirestore
            .collection("Posts")
            .doc(postData["postId"])
            .update({
          "likes": FieldValue.arrayRemove([_auth]),
        });
      } else {
        await _firebaseFirestore
            .collection("Posts")
            .doc(postData["postId"])
            .update({
          "likes": FieldValue.arrayUnion([_auth])
        });
      }
      postData["likes"].contains(_auth)
          ? postData["likes"].remove(_auth)
          : postData["likes"].add(_auth);
      update();
    } catch (e) {
      Get.snackbar("Error", "Failed to toggle like: $e");
    }
    update();
  }

  @override
  Future<void> fetchData() async {
    try {
      final data = await FireBaseServices().fetchDataFromFirebase();

      if (data.isEmpty) {
        // No more data available
        isLoading = false;
        hasError = false;
        return;
      }
      posts.assignAll(data);
      isLoading = false;
      hasError = false;

      update();
    } catch (error) {
      isLoading = false;
      hasError = true;

      update();
    }
    update();
  }

  @override
  Future<void> isisAnimating({required Map postData}) async {
    postData["likes"].contains(_auth);
    update();
  }

  @override
  showmodel(BuildContext context, Map data) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          children: [
            _auth == data["uid"]
                ? SimpleDialogOption(
                    onPressed: () async {
                      Get.back();
                      await _firebaseFirestore
                          .collection("Posts")
                          .doc(data["postId"])
                          .delete();
                      posts.removeWhere(
                          (post) => post["postId"] == data["postId"]);
                      update();
                    },
                    padding: const EdgeInsets.all(20).r,
                    child: Text(
                      "Delete post",
                      style: TextStyle(
                        fontSize: 18.sp,
                      ),
                    ),
                  )
                : SimpleDialogOption(
                    padding: const EdgeInsets.all(20).r,
                    child: Text(
                      "Can not delete this post ✋",
                      style: TextStyle(
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
            SimpleDialogOption(
              onPressed: () async {
                Get.back();
              },
              padding: const EdgeInsets.all(20).r,
              child: Text(
                "Cancel",
                style: TextStyle(
                  fontSize: 18.sp,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      Get.snackbar("Error", "Failed to sign out: $e");
    }
    update();
  }
}
