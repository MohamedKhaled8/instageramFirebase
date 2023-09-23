import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:instagramclone/core/constant/color.dart';
import 'package:instagramclone/view/home_view/home_screen.dart';
import 'package:instagramclone/view/profile_view/profile_screen.dart';
import 'package:instagramclone/controller/nav_bar_controller/nav_bar_controller.dart';

class CustomBottomNavBar extends StatelessWidget {
  final BottomNavigationBarControllerImp _bottomNavigationBarControllerImp =
      Get.put(BottomNavigationBarControllerImp());

   CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavigationBarControllerImp>(builder: (_) {
      return Scaffold(
        bottomNavigationBar: CupertinoTabBar(
            backgroundColor: mobileBackgroundColor,
            onTap: (index) {
              // navigate to the tabed page
              _bottomNavigationBarControllerImp.pageController
                  .jumpToPage(index);
              _bottomNavigationBarControllerImp.pageCont(index);
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    color: _bottomNavigationBarControllerImp.currentPage == 0
                        ? primaryColor
                        : secondaryColor,
                  ),
                  label: ""),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.search,
                    color: _bottomNavigationBarControllerImp.currentPage == 1
                        ? primaryColor
                        : secondaryColor,
                  ),
                  label: ""),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.add_circle,
                    color: _bottomNavigationBarControllerImp.currentPage == 2
                        ? primaryColor
                        : secondaryColor,
                  ),
                  label: ""),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite,
                    color: _bottomNavigationBarControllerImp.currentPage == 3
                        ? primaryColor
                        : secondaryColor,
                  ),
                  label: ""),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                    color: _bottomNavigationBarControllerImp.currentPage == 4
                        ? primaryColor
                        : secondaryColor,
                  ),
                  label: ""),
            ]),
        body: PageView(
        
          physics: const NeverScrollableScrollPhysics(),
          controller: _bottomNavigationBarControllerImp.pageController,
          children: const [
            HomeScreen(),
            // Search(),
            // AddPost(),
            Center(child: Text("Love u ♥")),
            ProfileScreen(),
          ],
        ),
      );
    });
  }
}
