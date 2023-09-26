import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:instagramclone/widgets/add_post/custom_upload_detailes_post.dart';
import 'package:instagramclone/widgets/add_post/custom_upload_photo_add_post.dart';
import 'package:instagramclone/controller/home_controller/add_post_controller.dart';


class AddPostScreen extends StatelessWidget {
  AddPostScreen({super.key});
  final AddPostControllerImp _addPostControllerImp =
      Get.put(AddPostControllerImp());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddPostControllerImp>(builder: (_) {
      return _addPostControllerImp.imgPath == null
          ? CustomUploadPhotoAddPost()
          : CustomUpladDetailesPost();
    });
  }
}



