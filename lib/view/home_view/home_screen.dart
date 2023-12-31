import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:instagramclone/core/constant/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagramclone/controller/home_controller/home_controller.dart';
import 'package:instagramclone/widgets/home_screen_widget/custom_person_photo.dart';
import 'package:instagramclone/widgets/home_screen_widget/custom_det_rev_image.dart';

class HomeScreen extends StatelessWidget {
  final HomeControllerImp _homeControllerImp = Get.put(HomeControllerImp());

  HomeScreen({super.key});
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
            GetBuilder<HomeControllerImp>(builder: (_) {
              return IconButton(
                onPressed: () async {
                  _homeControllerImp.signOut();
                },
                icon: const Icon(Icons.logout),
              );
            })
          ],
          title: Image.asset(
            "assets/png/instagram.png",
            color: primaryColor,
            height: 33.h,
          ),
        ),
        body: GetBuilder<HomeControllerImp>(
          builder: (_) {
            if (_homeControllerImp.isLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            } else if (_homeControllerImp.hasError) {
              const Center(
                child: Text('An error occurred while retrieving data'),
              );
            } else {
              return ListView.builder(
                  itemCount: _homeControllerImp.posts.length,
                  itemBuilder: (context, index) {
                    final data = _homeControllerImp.posts[index];
                    if (index == _homeControllerImp.posts.length - 1) {
                      // Reached the end, load more data
                      _homeControllerImp.fetchData();
                    }
                    return Column(
                      children: [
                        CustomPersonPostDesign(
                          data: data,
                        ),
                        CustomDetailesReviewImage(
                          data: data,
                        ),
                      ],
                    );
                  });
            }
            return const SizedBox();
          },
        ));
  }
}
