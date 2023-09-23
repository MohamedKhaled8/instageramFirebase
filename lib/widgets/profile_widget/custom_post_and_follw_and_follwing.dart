import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagramclone/widgets/custom_local/custom_text_local.dart';

class CustomPostAndFollwAndFollwing extends StatelessWidget {
  final String numeString;
  final String text;
  const CustomPostAndFollwAndFollwing({
    Key? key,
    required this.numeString,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextLocal(
            text: numeString,
            color: Colors.white,
            fontSize: 16.sp,
            height: 10,
            width: 10,
            alignment: Alignment.center),
        CustomTextLocal(
            text: text,
            color: Colors.white,
            fontSize: 16.sp,
            height: 0,
            width: 0,
            alignment: Alignment.center),
      ],
    );
  }
}