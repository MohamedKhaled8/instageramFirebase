import 'package:flutter/material.dart';
import 'package:instagramclone/core/constant/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// ignore_for_file: public_member_api_docs, sort_constructors_first


class CustomPersonPhoto extends StatelessWidget {
    final Map data;
  const CustomPersonPhoto({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 14.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(3.0).r,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: blueColor
                    ),
                    child: CircleAvatar(
                      radius: 25.r,
                      backgroundImage:  NetworkImage(
                         data["profileImg"],
                    ),
                  ),
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  Text(
                    data["username"],
                    style: TextStyle(color: Colors.white, fontSize: 18.sp),
                  ),
                ],
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ))
            ],
          ),
          Image.network(
            data["imgPost"],
            height: MediaQuery.of(context).size.height * 0.35,
            width: double.infinity,
          )
        ],
      ),
    );
  }
}
