import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class CustomTextLocal extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final double height;
  final double width;

  final Function()? onTap;
  AlignmentGeometry alignment = Alignment.center;
  CustomTextLocal({
    Key? key,
    required this.text,
    required this.color,
    required this.fontSize,
    required this.height,
    required this.width,
    this.onTap,
    required this.alignment,
  }) : super(key: key);
  TextOverflow? overflow;
  int? maxLines;
  FontWeight? fontWeight;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height.h, horizontal: width.w),
      child: InkWell(
        onTap: onTap,
        child: Align(
          alignment: alignment,
          child: Text(
            text,
            maxLines: maxLines,
            style: TextStyle(
              overflow: overflow,
              color: color,
              fontSize: fontSize,
              fontWeight: fontWeight,
            ),
          ),
        ),
      ),
    );
  }
}
