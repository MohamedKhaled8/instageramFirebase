import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagramclone/widgets/custom_bottom_bav_bar/custom_vab_bar.dart';

abstract class LoginScreenController extends GetxController {
  showPassword();
  Future<void> loginoFirebase({
    required String email,
    required String password,
  });
  Future<void> sendDataLoginUserToFirebase();
}

class LoginScreenControllerImp extends LoginScreenController {
  final TextEditingController emailLogCont = TextEditingController();
  final TextEditingController passwordLogCont = TextEditingController();
  final GlobalKey<FormState> formKeylog = GlobalKey<FormState>();
  bool isShowPassword = true;

  @override
  showPassword() {
    isShowPassword = !isShowPassword;
    update();
  }

  @override
  Future<void> loginoFirebase({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        Get.snackbar(
          "Login Successful",
          "تم تسجيل الدخول بنجاح",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        update();

        Get.offAll( CustomBottomNavBar());
      } else {
        Get.snackbar(
          "Login Failed",
          "فشل تسجيل الدخول",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
          "Authentication Error", e.message ?? "حدثت مشكلة في التسجيل الدخول");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
    update();
  }

  @override
  Future<void> sendDataLoginUserToFirebase() async {
    if (formKeylog.currentState!.validate()) {
      loginoFirebase(
        email: emailLogCont.text.trim(),
        password: passwordLogCont.text.trim(),
      );
    }
  }

  @override
  void dispose() {
    emailLogCont.dispose();
    passwordLogCont.dispose();
    super.dispose();
  }
}
