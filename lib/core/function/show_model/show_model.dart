import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

 class ShowModel {
  
  void fun () {
     showmodel(BuildContext context , {required String textOne , required String textTwo}) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(22).r,
          height: 170.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  // await uploadImage2Screen(ImageSource.camera);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.camera,
                      size: 30.h,
                    ),
                    SizedBox(
                      width: 11.w,
                    ),
                    Text(
                     textOne,
                      style: TextStyle(fontSize: 20.sp),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 22.h,
              ),
              GestureDetector(
                onTap: () {
                  // uploadImage2Screen(ImageSource.gallery);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.photo_outlined,
                      size: 30.h,
                    ),
                    SizedBox(
                      width: 11.w,
                    ),
                    Text(
                      textTwo,
                      style: TextStyle(fontSize: 20.sp),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  }
}
