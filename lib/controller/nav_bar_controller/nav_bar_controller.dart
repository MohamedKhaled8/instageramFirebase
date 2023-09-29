import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagramclone/view/profile_view/profile_screen.dart';

abstract class BottomNavigationBarController extends GetxController {
  void pageCont(int index);
  String getCurrentUserUid();
  void navigateToProfileScreen();
}

class BottomNavigationBarControllerImp extends BottomNavigationBarController {
  final PageController pageController = PageController();
  int currentPage = 0;
  @override
  String getCurrentUserUid() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      // يمكنك تنفيذ منطق هنا إذا لم يتم العثور على مستخدم مسجل داخل.
      return ""; // أو يمكنك إرجاع قيمة أخرى تُعبر عن عدم تسجيل الدخول.
    }
  }

  void navigateToProfileScreen() {
    final uid = getCurrentUserUid();
    Get.to(() =>
        ProfileScreen(uid: uid)); // قم بتمرير ال `uid` إلى ProfileScreen هنا
  }

  @override
  void pageCont(int index) {
    currentPage = index;
    update();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
