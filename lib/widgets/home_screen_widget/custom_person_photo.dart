import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagramclone/core/constant/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagramclone/core/animations/heart_animation.dart';
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
          SizedBox(
            height: 10.h,
          ),
          GestureDetector(
            onDoubleTap: () async {
              await _homeControllerImp.onClickPic(postData: data);
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.network(
                  data["imgPost"],
                  loadingBuilder: (context, child, loadingProgress) {
                    return loadingProgress == null
                        ? child
                        : SizedBox(
                            height: MediaQuery.of(context).size.height * 0.35,
                            child: const Center(
                                child: CircularProgressIndicator(
                              color: Colors.white,
                            )),
                          );
                  },
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: double.infinity,
                ),
                AnimatedOpacity(
                  opacity: _homeControllerImp.isLikeAnimating ? 1 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: LikeAnimation(
                    duration: const Duration(milliseconds: 400),
                    isAnimating: _homeControllerImp.isLikeAnimating,
                    onEnd: () {
                      _homeControllerImp.updateValues(false);
                    },
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 111,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  LikeAnimation(
                    isAnimating: data["likes"] != null &&
                        data["likes"]
                            .contains(FirebaseAuth.instance.currentUser?.uid),
                    smallLike: true,
                    child: IconButton(
                      onPressed: () async {
                        await _homeControllerImp.toggleLikes(postData: data);
                      },
                      icon: data["likes"] != null &&
                              data["likes"].contains(
                                  FirebaseAuth.instance.currentUser?.uid)
                          ? const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            )
                          : const Icon(
                              Icons.favorite_border,
                            ),
                    ),
                  ),
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
