import 'package:flutter/material.dart';
import 'package:instagramclone/core/constant/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagramclone/widgets/custom_local/custom_text_local.dart';
import 'package:instagramclone/widgets/profile_widget/custom_photo_pro_screen.dart';
import 'package:instagramclone/widgets/profile_widget/custom_buttom_edit_profile.dart';
import 'package:instagramclone/widgets/profile_widget/custom_grid_view_prof_photo.dart';
import 'package:instagramclone/widgets/profile_widget/custom_post_and_follw_and_follwing.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          title: const Text("Mohamed Khaled")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            Row(
              children: [
                const CustomPhotoProfileScreen(),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CustomPostAndFollwAndFollwing(
                        numeString: '1',
                        text: 'Post',
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      const CustomPostAndFollwAndFollwing(
                        numeString: '2',
                        text: 'Followers',
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      const CustomPostAndFollwAndFollwing(
                        numeString: '3',
                        text: 'Following',
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 25.h,
            ),
            CustomTextLocal(
                text: "Cute & nice girl",
                color: Colors.white,
                fontSize: 18.sp,
                height: 0,
                width: 15,
                alignment: Alignment.centerLeft),
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
            Row(
              children: [
                CustomButtomLocal(
                  onTap: () {},
                  height: 45,
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
                  height: 45,
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
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
                margin: const EdgeInsets.all(5.0).r,
                height: 500.h,
                child: const Expanded(child: CustomGridViewProfilePhoto()))
          ],
        ),
      ),
    );
  }
}
