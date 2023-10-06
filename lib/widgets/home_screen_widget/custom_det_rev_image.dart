import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagramclone/view/comment_view/comment_screen.dart';
import 'package:instagramclone/widgets/custom_local/custom_text_local.dart';
import 'package:instagramclone/controller/home_controller/home_controller.dart';

class CustomDetailesReviewImage extends StatefulWidget {
  final Map data;

  const CustomDetailesReviewImage({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<CustomDetailesReviewImage> createState() =>
      _CustomDetailesReviewImageState();
}

class _CustomDetailesReviewImageState extends State<CustomDetailesReviewImage> {
  int commentCount = 0;
  getCommentCount() async {
    try {
      QuerySnapshot commentdata = await FirebaseFirestore.instance
          .collection("Posts")
          .doc(widget.data["postId"])
          .collection("Comments")
          .get();

      setState(() {
        commentCount = commentdata.docs.length;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    getCommentCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime datePublished;

    if (widget.data["datePublished"] is int) {
      datePublished = DateTime.fromMillisecondsSinceEpoch(
          widget.data["datePublished"] * 1000);
    } else {
      datePublished = widget.data["datePublished"].toDate();
    }
    return Column(
      children: [
        CustomTextLocal(
          text:
              "${widget.data["likes"].length} ${widget.data["likes"].length > 1 ? "Likes" : "Like"}",
          color: const Color.fromARGB(214, 157, 157, 165),
          fontSize: 18.sp,
          alignment: Alignment.bottomLeft,
          height: 5,
          width: 10,
        ),
        CustomTextLocal(
          text: widget.data["username"],
          color: const Color.fromARGB(214, 157, 157, 165),
          fontSize: 18.sp,
          alignment: Alignment.bottomLeft,
          height: 5,
          width: 10,
        ),
        CustomTextLocal(
          text: widget.data["description"],
          color: const Color.fromARGB(214, 157, 157, 165),
          fontSize: 18.sp,
          alignment: Alignment.bottomLeft,
          height: 5,
          width: 10,
        ),
        CustomTextLocal(
          onTap: () {
            Get.to(() => CommentsScreen(
                  data: widget.data,
                  showTextField: false,
                ));
          },
          text: "view all $commentCount comments",
          color: const Color.fromARGB(214, 157, 157, 165),
          fontSize: 18.sp,
          alignment: Alignment.bottomLeft,
          height: 5,
          width: 10,
        ),
        CustomTextLocal(
          text:
              DateFormat('MMMM d, ' 'y').format(datePublished), // تنسيق التاريخ
          color: const Color.fromARGB(214, 157, 157, 165),
          fontSize: 18.sp,
          alignment: Alignment.bottomLeft,
          height: 5,
          width: 10,
        ),
      ],
    );
  }
}
