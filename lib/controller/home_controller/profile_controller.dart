import 'package:get/get.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagramclone/core/services/fire_base_services/db/firebase_sevices.dart';

abstract class ProfileController extends GetxController {
  Future<void> getData(String uiddd);
  Future<void> filterPostUser(String uiddd);
  void updateIsCurrentUser(String uid);
  Future<void> getUsers(String userName);
}

class ProfileControllerImp extends ProfileController {
  Map userData = {};
  bool isLoading = true;
  int followers = 0;
  int following = 0;
  var filterPostList = [].obs;
  int postCount = 0;
  bool isCurrentUser = false;
  var showBackButton = false;
  var searchResults = <Map<String, dynamic>>[];
  var users = <QueryDocumentSnapshot>[];
  final TextEditingController myController = TextEditingController();

  @override
  Future<void> getUsers(String userName) async {
    try {
      var query = await FirebaseFirestore.instance
          .collection('Users')
          .where("name", isEqualTo: userName)
          .get();
      users.assignAll(query.docs);
    } catch (e) {
      // print("Error fetching user data: $e");
    }
  }

  @override
  Future<void> getData(String uiddd) async {
    isLoading = true;
    update();

    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('Users').doc(uiddd).get();

      userData = snapshot.data()!;
      followers = userData["followers"].length;
      following = userData["following"].length;
      filterPostUser(uiddd);

      updateIsCurrentUser(uiddd);
    } catch (e) {
      Get.snackbar(e.toString(), "${Text(e.toString())}");
    }

    isLoading = false;
    update();
  }

  @override
  Future<void> filterPostUser(String uiddd) async {
    try {
      final result = await FireBaseServices().filterPostUser(uiddd);
      filterPostList.assignAll(result["filterPostList"]);
      postCount = result["postCount"];
    } catch (e) {
      Get.snackbar(e.toString(), "${Text(e.toString())}");
    }
    update();
  }

  @override
  void updateIsCurrentUser(String uid) {
    isCurrentUser = (uid == FirebaseAuth.instance.currentUser!.uid);
    update();
  }

  @override
  void onInit() {
    final String uiddd = FirebaseAuth.instance.currentUser!.uid;

    getData(uiddd);
    filterPostUser(uiddd);
    updateIsCurrentUser(uiddd);
    super.onInit();
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }
}
