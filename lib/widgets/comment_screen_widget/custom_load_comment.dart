import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../controller/home_controller/comment_controller.dart';

class CustomLoadComment extends StatelessWidget {
  CustomLoadComment({
    super.key,
  });

  final CommentControllerImp _commentControllerImp = Get.find();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children:
            _commentControllerImp.comments.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
          return Container(
            margin: const EdgeInsets.only(bottom: 15).r,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 12).r,
                      padding: const EdgeInsets.all(5).r,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(125, 78, 91, 110),
                      ),
                      child: CircleAvatar(
                        backgroundImage:
                            NetworkImage(data["profilePic"] ?? "profilePic"),
                        radius: 26.r,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(data["username"] ?? "No Username",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17.sp)),
                            SizedBox(
                              width: 11.w,
                            ),
                            Text(data["textComment"] ?? "textComment",
                                style: TextStyle(fontSize: 16.sp))
                          ],
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Text(
                            DateFormat('MMM d, ' 'y').format(
                                data["dataPublished"].toDate() ??
                                    "dataPublished"),
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ))
                      ],
                    ),
                  ],
                ),
                IconButton(onPressed: () {}, icon: const Icon(Icons.favorite))
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
