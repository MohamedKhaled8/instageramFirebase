import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:instagramclone/core/services/fire_base_services/db/firebase_sevices.dart';

abstract class HomeController extends GetxController {
  void signOut();
  Future<void> fetchData();
  // Future<void> getCommentCount();
  showmodel(BuildContext context, Map data);
}

class HomeControllerImp extends HomeController {
  final isLoading = true.obs;
  final hasError = false.obs;
  final posts = List<Map<String, dynamic>>.empty().obs;
  RxInt commentCount = 0.obs;

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  @override
  void onInit() {
    super.onInit();
    fetchData();
    // getCommentCount();
  }

  // @override
  // Future<void> getCommentCount() async {
  //   try {
  //     QuerySnapshot<Map<String, dynamic>> commentData = await _firebaseFirestore
  //         .collection("Posts")
  //         .doc(data["postId"])
  //         .collection("Comments")
  //         .get();
  //     print("Start");
  //     commentCount.value = commentData.docs.length;
  //     print("End");
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  @override
  Future<void> fetchData() async {
    try {
      final data = await FireBaseServices().fetchDataFromFirebase();

      posts.assignAll(data);
      isLoading.value = false;
      hasError.value = false;

      update();
    } catch (error) {
      isLoading.value = false;
      hasError.value = true;

      update();
    }
  }

  @override
  showmodel(BuildContext context, Map data) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          children: [
            FirebaseAuth.instance.currentUser!.uid == data["uid"]
                ? SimpleDialogOption(
                    onPressed: () async {
                      Get.back();
                      await FirebaseFirestore.instance
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
    await FirebaseAuth.instance.signOut();
    update();
  }
}
