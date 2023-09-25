import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:instagramclone/core/constant/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagramclone/controller/home_controller/profile_controller.dart';

class CustomPhotoProfileScreen extends StatelessWidget {
   CustomPhotoProfileScreen({
    super.key,
  });
  final ProfileControllerImp _profileControllerImp = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.w),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: blueColor,
      ),
      child: CircleAvatar(
        radius: 33.r,
        backgroundImage:  NetworkImage(
           _profileControllerImp.userData["profileImg"] ),
      ),
    );
  }
}
