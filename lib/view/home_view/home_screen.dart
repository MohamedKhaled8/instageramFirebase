import 'package:flutter/material.dart';
import 'package:instagramclone/core/constant/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/home_screen_widget/custom_icon_actions.dart';
import 'package:instagramclone/widgets/home_screen_widget/custom_person_photo.dart';
import 'package:instagramclone/widgets/home_screen_widget/custom_det_rev_image.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: mobileBackgroundColor,
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.message_outlined),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.logout),
            ),
          ],
          title: Image.asset(
            "assets/png/instagram.png",
            color: primaryColor,
            height: 33.h,
          ),
        ),
        body: const SingleChildScrollView(
          child: Column(
            children: [
              CustomPersonPhoto(),
              CustomIconsActions(),
              CustomDetailesReviewImage(),
              CustomPersonPhoto(),
              CustomIconsActions(),
              CustomDetailesReviewImage(),
            ],
          ),
        ));
  }
}

