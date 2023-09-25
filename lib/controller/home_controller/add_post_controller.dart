import 'dart:math';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show basename;
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AddPostController extends GetxController {
  uploadImage2Screen(ImageSource source);
  showmodel(BuildContext context);
  Future<void> getPhotoToAddPost();
}

class AddPostControllerImp extends AddPostController {
  bool isLoading = false;
  Uint8List? imgPath;
  String? imgName;
  Map userData = {};
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
  Future<void> getPhotoToAddPost() async {
    isLoading = true;
    update();
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      userData = snapshot.data()!;
    } catch (e) {
      print(e.toString());
    }

    isLoading = false;
    update();
  }

  void checkImagePath() {
    imgPath = null;
    update();
  }

  void funisLoading() {
    isLoading = true;
    update();
  }
  @override
  void onInit() {
getPhotoToAddPost() ;
    super.onInit();
  }
}
