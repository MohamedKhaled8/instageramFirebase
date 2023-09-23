import 'dart:math';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show basename;
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagramclone/core/constant/color.dart';
import 'package:instagramclone/core/model/users_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagramclone/view/auth/login_screen.dart';
import 'package:instagramclone/widgets/auth/register/custom_check_valid.dart';
import 'package:instagramclone/core/services/fire_base_services/cloud/cloud_image.dart';
import 'package:instagramclone/core/services/fire_base_services/db/firebase_sevices.dart';

abstract class RegisterController extends GetxController {
  showPassword();
  onPasswordChanged(String password);
  visibilityOnPasswordChanged();
  Future<void> signUpFirebase({
    required String name,
    required String title,
    required String email,
    required String password,
    required imgName,
    required imgPath,
  });
  uploadImage2Screen(ImageSource source);
  showmodel(BuildContext context);
  Future<void> sendDataUserToFirebase();
}

class RegisterControllerImp extends RegisterController {
  final TextEditingController nameRegisterCont = TextEditingController();
  final TextEditingController titleRegisterCont = TextEditingController();
  final TextEditingController emailRegisterCont = TextEditingController();
  final TextEditingController passwordRegisterCont = TextEditingController();
  final GlobalKey<FormState> formKeyReg = GlobalKey<FormState>();
  bool isShowPassword = true;
  bool isPassword8Char = false;
  bool isPasswordHas1Number = false;
  bool hasUppercase = false;
  bool hasLowercase = false;
  bool hasSpecialCharacters = false;
  bool showPasswordStrength = false;
  bool isLoading = false;
  var isSignedIn = false;
  Uint8List? imgPath;
  String? imgName;

  @override
  uploadImage2Screen(ImageSource source) async {
    Get.back();
    final XFile? pickedImg = await ImagePicker().pickImage(source: source);
    try {
      if (pickedImg != null) {
        imgPath = (await pickedImg.readAsBytes());
        imgName = basename(pickedImg.path);
        int random = Random().nextInt(9999999);
        imgName = "$random$imgName";
      } else {
        Get.snackbar("Error", "${const Text("NO img selected")}");
      }
    } catch (e) {
      Get.snackbar("Error", "${Text(e.toString())}");
    }
    update();
  }

  @override
  showmodel(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(22).r,
          height: 170.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  await uploadImage2Screen(ImageSource.camera);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.camera,
                      size: 30.h,
                    ),
                    SizedBox(
                      width: 11.w,
                    ),
                    Text(
                      "From Camera",
                      style: TextStyle(fontSize: 20.sp),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 22.h,
              ),
              GestureDetector(
                onTap: () {
                  uploadImage2Screen(ImageSource.gallery);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.photo_outlined,
                      size: 30.h,
                    ),
                    SizedBox(
                      width: 11.w,
                    ),
                    Text(
                      "From Gallery",
                      style: TextStyle(fontSize: 20.sp),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  onPasswordChanged(String password) {
    isPassword8Char = false;
    isPasswordHas1Number = false;
    hasUppercase = false;
    hasLowercase = false;
    hasSpecialCharacters = false;
    if (password.contains(RegExp(r'.{8,}'))) {
      isPassword8Char = true;
    }

    if (password.contains(RegExp(r'[0-9]'))) {
      isPasswordHas1Number = true;
    }

    if (password.contains(RegExp(r'[A-Z]'))) {
      hasUppercase = true;
    }

    if (password.contains(RegExp(r'[a-z]'))) {
      hasLowercase = true;
    }

    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      hasSpecialCharacters = true;
    }
    showPasswordStrength = true;
    update();
  }

  @override
  List<Widget> visibilityOnPasswordChanged() {
    List<Widget> widgets = [];

    if (isPassword8Char) {
      widgets.add(
        CustomCheckValidate(
          text: 'At least 8 characters',
          color: isPassword8Char ? Colors.green : primaryColor,
        ),
      );
    }
    widgets.add(SizedBox(height: 10.h));

    if (isPasswordHas1Number) {
      widgets.add(
        CustomCheckValidate(
          color: isPasswordHas1Number ? Colors.green : primaryColor,
          text: 'At least 1 Number',
        ),
      );
    }
    widgets.add(SizedBox(height: 10.h));

    if (hasUppercase) {
      widgets.add(
        CustomCheckValidate(
          color: hasUppercase ? Colors.green : primaryColor,
          text: 'has UpperCase',
        ),
      );
    }
    widgets.add(SizedBox(height: 10.h));

    if (hasLowercase) {
      widgets.add(
        CustomCheckValidate(
          color: hasLowercase ? Colors.green : primaryColor,
          text: 'Has Lowercase ',
        ),
      );
    }
    widgets.add(SizedBox(height: 10.h));

    if (hasSpecialCharacters) {
      widgets.add(
        CustomCheckValidate(
          color: hasSpecialCharacters ? Colors.green : primaryColor,
          text: 'has special characters  ',
        ),
      );
    }

    return widgets;
  }

  @override
  Future<void> signUpFirebase({
    required String name,
    required String title,
    required String email,
    required String password,
    required imgName,
    required imgPath,
  }) async {
    String message = "ERROR => Not starting the code";

    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      message = "ERROR => Registered only";

      final cloudFireBaseStorge = CloudFireBaseStorge();

      String imageUrl = await cloudFireBaseStorge.getImgURL(
        imgName: imgName,
        imgPath: imgPath,
      );
      final userModel = UsersModel(
        name: name,
        title: title,
        email: email,
        password: password,
        profileImg: imageUrl,
        uid: credential.user!.uid,
      );
      final firestoreServices = FireBaseServices();
      await firestoreServices.addUserToDatabase(
        uid: credential.user!.uid,
        userModel: userModel,
      );
      message = "Registered & User Added 2 DB ♥";

      update();
      await Get.offAll(LoginScreen());
    } on FirebaseAuthException catch (error) {
      String title = error.code.replaceAll(RegExp('-'), ' ').capitalize!;
      String message = '';
      if (error.code == 'weak-password') {
        message = 'Provided Password is too weak..';
      } else if (error.code == 'email-already-in-use') {
        message = 'Account Already exists for that email..';
      } else {
        message = error.message.toString();
      }
      Get.snackbar(
        title,
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (error) {
      Get.snackbar(
        message,
        error.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }

    update();
  }

  @override
  Future<void> sendDataUserToFirebase() async {
    if (formKeyReg.currentState!.validate() &&
        imgName != null &&
        imgPath != null) {
      signUpFirebase(
        email: emailRegisterCont.text.trim(),
        password: passwordRegisterCont.text.trim(),
        name: nameRegisterCont.text.trim(),
        title: titleRegisterCont.text.trim(),
        imgName: imgName,
        imgPath: imgPath,
      );
    }
  }

  @override
  showPassword() {
    isShowPassword = !isShowPassword;
    update();
  }

  @override
  void dispose() {
    nameRegisterCont.dispose();
    titleRegisterCont.dispose();
    emailRegisterCont.dispose();
    passwordRegisterCont.dispose();
    super.dispose();
  }
}
