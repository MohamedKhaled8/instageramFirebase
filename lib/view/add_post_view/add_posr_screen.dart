import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:instagramclone/core/constant/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagramclone/controller/home_controller/add_post_controller.dart';

class AddPostScreen extends StatelessWidget {
  AddPostScreen({super.key});
  final AddPostControllerImp _addPostControllerImp =
      Get.put(AddPostControllerImp());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddPostControllerImp>(builder: (_) {
      return _addPostControllerImp.imgPath == null
          ? Scaffold(
              backgroundColor: mobileBackgroundColor,
              body: Center(
                child: IconButton(
                  onPressed: () {
                    _addPostControllerImp.showmodel(context);
                  },
                  icon: Icon(
                    Icons.upload,
                    size: 30.h,
                  ),
                ),
              ),
            )
          : Scaffold(
              backgroundColor: mobileBackgroundColor,
              appBar: AppBar(
                actions: [
                  TextButton(
                      onPressed: () {
                        _addPostControllerImp.funisLoading();
                      },
                      child: Text(
                        "Post",
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 19.sp,
                            fontWeight: FontWeight.bold),
                      )),
                ],
                backgroundColor: mobileBackgroundColor,
                leading: IconButton(
                    onPressed: () {
                      _addPostControllerImp.checkImagePath();
                    },
                    icon: const Icon(Icons.arrow_back)),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    _addPostControllerImp.isLoading
                        ? const LinearProgressIndicator()
                        : Divider(
                            thickness: 1,
                            height: 30.h,
                            color: Colors.white,
                            endIndent: 25.w,
                            indent: 25.w,
                          ),
                          SizedBox(height: 16.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 30.r,
                          backgroundImage:  NetworkImage(
                            _addPostControllerImp.userData["profileImg"],
                          ),
                        ),
                        Container(
                          width: 250.w,
                          height: 45.h,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(15).r),
                          child: TextFormField(
                            // controller: descriptionController,
                            maxLines: 8,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 35.h),
                                hintText: "write a caption...",
                                border: InputBorder.none),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      height: 150.h,
                      width: 320.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            20.0), // Adjust the radius as needed
                        image: DecorationImage(
                          image: MemoryImage(
                            _addPostControllerImp.imgPath!,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
    });
  }
}
