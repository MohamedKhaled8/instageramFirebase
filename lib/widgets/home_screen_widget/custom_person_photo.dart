import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagramclone/core/constant/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagramclone/view/comment_view/comment_screen.dart';
import 'package:instagramclone/controller/home_controller/home_controller.dart';

class CustomPersonPostDesign extends StatelessWidget {
  final Map data;
  CustomPersonPostDesign({
    Key? key,
    required this.data,
  }) : super(key: key);
  final HomeControllerImp _homeControllerImp = Get.find();

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
                        shape: BoxShape.circle, color: blueColor),
                    child: CircleAvatar(
                      radius: 25.r,
                      backgroundImage: NetworkImage(
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
                  onPressed: () {
                    _homeControllerImp.showmodel(context, data);
                  },
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
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                      )),
                  IconButton(
                      onPressed: () {
                        Get.to(() =>
                            CommentsScreen(data: data, showTextField: true));
                      },
                      icon: const Icon(
                        Icons.comment_outlined,
                        color: Colors.white,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.send,
                        color: Colors.white,
                      )),
                ],
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.bookmark_outline,
                    color: Colors.white,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
