import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:instagramclone/core/constant/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../controller/home_controller/add_post_controller.dart';


class CustomUploadPhotoAddPost extends StatelessWidget {
  CustomUploadPhotoAddPost({
    super.key,
  });

  final AddPostControllerImp _addPostControllerImp = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      body: Center(
        child: IconButton(
          onPressed: () {
            _addPostControllerImp.showmodel(context);
          },
          icon: Icon(
            Icons.upload,
            size: 30.h,
          ),
        ),
      ),
    );
  }
}
