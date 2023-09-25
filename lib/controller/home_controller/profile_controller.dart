import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ProfileController extends GetxController {
  Future<void> getData();
}

class ProfileControllerImp extends ProfileController {
  Map userData = {};
  bool isLoading = true;
  int followers = 0;
  int following = 0;

  @override
  Future<void> getData() async {
    isLoading = true;
    update();
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      userData = snapshot.data()!;

      followers = userData["followers"].length;
      following = userData["following"].length;
    } catch (e) {
      print(e.toString());
    }

    isLoading = false;
    update();
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }
}
