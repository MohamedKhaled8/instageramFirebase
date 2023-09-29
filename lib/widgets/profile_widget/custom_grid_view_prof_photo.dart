import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagramclone/controller/home_controller/profile_controller.dart';

class CustomGridViewProfilePhoto extends StatelessWidget {
  CustomGridViewProfilePhoto({super.key});
  final ProfileControllerImp _profileControllerImp = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_profileControllerImp.filterPostList.isEmpty) {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        );
      } else if (_profileControllerImp.filterPostList.isNotEmpty) {
        return GridView.builder(
            itemCount: _profileControllerImp.filterPostList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: ((context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(10).r,
                child: Image.network(
                  _profileControllerImp.filterPostList[index]["imgPost"],
                  fit: BoxFit.cover,
                ),
              );
            }));
      } else {
        return const Text("Something went wrong");
      }
    });
  }
}
