import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagramclone/widgets/custom_local/custom_text_local.dart';

class CustomDetailesReviewImage extends StatelessWidget {
  final Map data;

  const CustomDetailesReviewImage({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime datePublished;

    if (data["datePublished"] is int) {
      datePublished =
          DateTime.fromMillisecondsSinceEpoch(data["datePublished"] * 1000);
    } else {
      datePublished = data["datePublished"].toDate();
    }
    return Column(
      children: [
        CustomTextLocal(
          text:
              "${data["likes"].length} ${data["likes"].length > 1 ? "Likes" : "Like"}",
          color: const Color.fromARGB(214, 157, 157, 165),
          fontSize: 18.sp,
          alignment: Alignment.bottomLeft,
          height: 5,
          width: 10,
        ),
        CustomTextLocal(
          text: data["username"],
          color: const Color.fromARGB(214, 157, 157, 165),
          fontSize: 18.sp,
          alignment: Alignment.bottomLeft,
          height: 5,
          width: 10,
        ),
        CustomTextLocal(
          text: data["description"],
          color: const Color.fromARGB(214, 157, 157, 165),
          fontSize: 18.sp,
          alignment: Alignment.bottomLeft,
          height: 5,
          width: 10,
        ),
        CustomTextLocal(
          text: 'View All 100 Comments',
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
