import 'package:flutter/material.dart';
import 'package:instagramclone/core/constant/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomPersonPhoto extends StatelessWidget {
  const CustomPersonPhoto({
    super.key,
  });

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
                      radius: 30.r,
                      backgroundImage: const NetworkImage(
                          "https://cdn.pixabay.com/photo/2023/08/21/23/11/woman-8205187_1280.jpg"),
                    ),
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  Text(
                    "Name K",
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
            "https://cdn.pixabay.com/photo/2023/09/03/11/13/mountains-8230502_1280.jpg",
            height: MediaQuery.of(context).size.height * 0.35,
            width: double.infinity,
          )
        ],
      ),
    );
  }
}
