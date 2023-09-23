import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class CustomButtomLocal extends StatelessWidget {
  final Function()? onTap;
  final String text;
  bool isIcon = true;

  CustomButtomLocal({
    Key? key,
    required this.onTap,
    required this.text,
    required this.height,
    required this.width,
    this.border,
    this.radius,
    this.color,
    this.colorText,
    this.fontSize,
    this.icon,
    this.colorIcon,
    this.iconSize,
    required this.isIcon,
  }) : super(key: key);
  final double height;

  final double width;

  BoxBorder? border;
  double? radius;
  Color? color;
  Color? colorText;
  Color? colorIcon;
  double? fontSize;
  double? iconSize;
  IconData? icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        height: height.h,
        width: width.w,
        decoration: BoxDecoration(
          border: border,
          color: color,
          borderRadius: BorderRadius.circular(radius ?? 0.0),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isIcon
                  ? IconButton(
                      onPressed: () {},
                      icon: Icon(
                        icon,
                        color: colorIcon,
                        size: iconSize,
                      ))
                  : const SizedBox(),
              Text(
                text,
                style: TextStyle(color: colorText, fontSize: fontSize),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
