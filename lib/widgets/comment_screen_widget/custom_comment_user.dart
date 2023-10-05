import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagramclone/controller/home_controller/comment_controller.dart';

class CustomCommentUser extends StatelessWidget {
  CustomCommentUser({
    super.key,
    required this.data,
  });

  final Map data;
  final CommentControllerImp _commentControllerImp = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12).r,
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 20, left: 10).r,
            padding: const EdgeInsets.all(5).r,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(124, 78, 91, 110),
            ),
            child: CircleAvatar(
              backgroundImage: NetworkImage(data["profileImg"]),
              radius: 26.r,
            ),
          ),
          Expanded(
            child: TextField(
                controller: _commentControllerImp.commentController,
                keyboardType: TextInputType.text,
                obscureText: false,
                decoration: InputDecoration(
                    hintText: "Comment as  ${data["username"]}  ",
                    suffixIcon: IconButton(
                        onPressed: () async {
                          await _commentControllerImp.uploadComment(
                            commentText:
                                _commentControllerImp.commentController.text,
                            postId: data["postId"],
                            profileImg: data["profileImg"],
                            username: data["username"],
                            uid: _commentControllerImp.getUser!.uid,
                          );

                          _commentControllerImp.clearTextCont();
                        },
                        icon: const Icon(Icons.send)))),
          ),
        ],
      ),
    );
  }
}
