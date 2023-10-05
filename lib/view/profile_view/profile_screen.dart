import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:instagramclone/core/constant/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagramclone/widgets/custom_local/custom_text_local.dart';
import 'package:instagramclone/controller/home_controller/profile_controller.dart';
import 'package:instagramclone/widgets/profile_widget/custom_photo_pro_screen.dart';
import 'package:instagramclone/widgets/profile_widget/custom_buttom_edit_profile.dart';
import 'package:instagramclone/widgets/profile_widget/custom_grid_view_prof_photo.dart';
import 'package:instagramclone/widgets/profile_widget/custom_post_and_follw_and_follwing.dart';

class ProfileScreen extends StatelessWidget {
  final String uid;
  ProfileScreen({
    Key? key,
    required this.uid,
  }) : super(key: key);
  final ProfileControllerImp _profileControllerImp =
      Get.put(ProfileControllerImp());

  @override
  Widget build(BuildContext context) {
    _profileControllerImp.getData(uid);

    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: GetBuilder<ProfileControllerImp>(
          builder: (_) {
            return _profileControllerImp.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Text(_profileControllerImp.userData["name"]);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            Row(
              children: [
                GetBuilder<ProfileControllerImp>(builder: (_) {
                  return CustomPhotoProfileScreen();
                }),
                Expanded(
                  child: Column(
                    children: [
                      GetBuilder<ProfileControllerImp>(builder: (_) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomPostAndFollwAndFollwing(
                              numeString:
                                  _profileControllerImp.postCount.toString(),
                              text: 'Post',
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            CustomPostAndFollwAndFollwing(
                              numeString:
                                  _profileControllerImp.followers.toString(),
                              text: 'Followers',
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            CustomPostAndFollwAndFollwing(
                              numeString:
                                  _profileControllerImp.following.toString(),
                              text: 'Following',
                            ),
                          ],
                        );
                      })
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 25.h,
            ),
            GetBuilder<ProfileControllerImp>(builder: (_) {
              return CustomTextLocal(
                text: _profileControllerImp.userData["title"],
                color: Colors.white,
                fontSize: 18.sp,
                height: 0,
                width: 15,
                alignment: Alignment.centerLeft,
              );
            }),
            SizedBox(
              height: 10.h,
            ),
            const Divider(
              color: Colors.white,
              thickness: 0.10,
              endIndent: 25,
              indent: 25,
            ),
            SizedBox(
              height: 10.h,
            ),
            GetBuilder<ProfileControllerImp>(builder: (_) {
              return _profileControllerImp.isCurrentUser
                  ? Row(
                      children: [
                        CustomButtomLocal(
                          onTap: () {},
                          height: 40,
                          width: 140,
                          radius: 15,
                          border: Border.all(color: Colors.white, width: 0),
                          text: 'Edit Profile',
                          colorText: Colors.white,
                          icon: Icons.edit,
                          fontSize: 16.sp,
                          iconSize: 20.sp,
                          colorIcon: Colors.white,
                          isIcon: true,
                        ),
                        CustomButtomLocal(
                          onTap: () {},
                          isIcon: true,
                          height: 40,
                          width: 140,
                          radius: 15,
                          color: const Color.fromARGB(143, 255, 55, 112),
                          fontSize: 16.sp,
                          // border: Border.all(color: Colors.white, width: 0),
                          text: 'Log Out',
                          colorText: Colors.white,
                          icon: Icons.logout,
                          iconSize: 25.sp,
                          colorIcon: Colors.white,
                        ),
                      ],
                    )
                  : CustomButtomLocal(
                      onTap: () {
                        if (_profileControllerImp.showFollow) {
                          _profileControllerImp.isIncrease(true);
                          _profileControllerImp.isBool(false);
                          _profileControllerImp.updateFollowersAndFollowing(
                              _profileControllerImp.auth, uid);
                        } else {
                          _profileControllerImp.isIncrease(false);
                          _profileControllerImp.isBool(true);
                          _profileControllerImp.updateFollowersAndFollowing(
                              _profileControllerImp.auth, uid);
                        }
                      },
                      isIcon: false,
                      height: 40,
                      width: 210,
                      radius: 15,
                      color: _profileControllerImp.showFollow
                          ? Colors.blue
                          : const Color.fromARGB(143, 255, 55, 112),
                      fontSize: 20.sp,
                      text: _profileControllerImp.showFollow
                          ? 'Follow'
                          : 'unFollow',
                      colorText: Colors.white,
                      colorIcon: Colors.white,
                    );
            }),
            SizedBox(
              height: 20.h,
            ),
            Container(
              margin: const EdgeInsets.all(5.0).copyWith(right: 5.0),
              height: 500.h,
              child: CustomGridViewProfilePhoto(),
            )
          ],
        ),
      ),
    );
  }
}
