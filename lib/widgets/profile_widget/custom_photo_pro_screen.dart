import 'package:flutter/material.dart';
import 'package:instagramclone/core/constant/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomPhotoProfileScreen extends StatelessWidget {
  const CustomPhotoProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.w),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: blueColor,
      ),
      child: CircleAvatar(
        radius: 33.r,
        backgroundImage: const NetworkImage(
            "https://cdn.pixabay.com/photo/2023/08/21/23/11/woman-8205187_1280.jpg"),
      ),
    );
  }
}