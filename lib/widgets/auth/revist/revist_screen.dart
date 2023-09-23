import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:instagramclone/core/constant/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagramclone/view/auth/register_screen.dart';
import 'package:instagramclone/widgets/custom_local/custom_text_local.dart';

class RevistScreen extends StatelessWidget {
  final String text;
  final String textButton;
  const RevistScreen({
    Key? key,
    required this.text,
    required this.textButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomTextLocal(
            text: text,
            color: Colors.white,
            fontSize: 16.sp,
            height: 0,
            width: 30,
            alignment: Alignment.centerLeft),
        TextButton(
            onPressed: () {
              Get.to( RegisterScreen());
            },
            child: Text(
              textButton,
              style: TextStyle(
                  color: blueColor,
                  fontSize: 20.sp,
                  decoration: TextDecoration.underline),
            ))
      ],
    );
  }
}