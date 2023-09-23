import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:instagramclone/core/constant/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagramclone/widgets/custom_local/custom_text_local.dart';
import 'package:instagramclone/controller/auth/register_controller/register_controller.dart';

class CustomCheckValidate extends StatelessWidget {
  final String text;
  final Color color;
  // ignore: unused_field
  final RegisterControllerImp _registerControllerImp = Get.find();
  CustomCheckValidate({
    Key? key,
    required this.text,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 20.h,
          width: 20.w,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
              border:
                  Border.all(color: const Color.fromARGB(255, 189, 189, 189))),
          child: Icon(Icons.check, color: primaryColor, size: 18.sp),
        ),
        SizedBox(
          width: 10.w,
        ),
        CustomTextLocal(
            text: text,
            color: Colors.white,
            fontSize: 16.sp,
            height: 0,
            width: 0,
            alignment: Alignment.center)
      ],
    );
  }
}
