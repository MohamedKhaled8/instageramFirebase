import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:instagramclone/core/constant/color.dart';
import 'package:instagramclone/controller/home_controller/comment_controller.dart';
import 'package:instagramclone/widgets/comment_screen_widget/custom_comment_user.dart';
import 'package:instagramclone/widgets/comment_screen_widget/custom_load_comment.dart';
// ignore_for_file: must_be_immutable


class CommentsScreen extends StatelessWidget {
  final Map data;
  bool showTextField = true;
  CommentsScreen({Key? key, required this.data, required this.showTextField})
      : super(key: key);

  final CommentControllerImp _commentControllerImp =
      Get.put(CommentControllerImp());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: const Text(
          'Comments',
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GetBuilder<CommentControllerImp>(builder: (_) {
            _commentControllerImp.loadComments(data["postId"]);
            return CustomLoadComment();
          }),
          showTextField
              ? GetBuilder<CommentControllerImp>(builder: (_) {
                  if (_commentControllerImp.getUser != null) {
                    return CustomCommentUser(
                      data: data,
                    );
                  } else {
                    return const CircularProgressIndicator(
                      color: Colors.white,
                    );
                  }
                })
              : const SizedBox(),
        ],
      ),
    );
  }
}
