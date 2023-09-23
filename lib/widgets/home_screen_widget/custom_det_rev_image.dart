import 'package:flutter/cupertino.dart';
import 'package:instagramclone/core/constant/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagramclone/widgets/custom_local/custom_text_local.dart';

class CustomDetailesReviewImage extends StatelessWidget {
  const CustomDetailesReviewImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextLocal(
          text: '10 Likes',
          color: primaryColor,
          fontSize: 16.sp, alignment: Alignment.bottomLeft, height: 5, width: 10,
        ),
        CustomTextLocal(
          text: 'UserName Countries',
          color: primaryColor,
          fontSize: 16.sp, alignment: Alignment.bottomLeft, height: 5, width: 10,
        ),
        CustomTextLocal(
          text: 'View All 100 Comments',
          color: primaryColor,
          fontSize: 16.sp, alignment: Alignment.bottomLeft, height: 5, width: 10,
        ),
       
      ],
    );
  }
}
