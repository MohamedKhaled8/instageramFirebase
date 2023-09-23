import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

abstract class BottomNavigationBarController extends GetxController {
   void pageCont(int index);
}

class BottomNavigationBarControllerImp extends BottomNavigationBarController {
  final PageController pageController = PageController();
  int currentPage = 0;

  @override
  void pageCont(int index) {
    currentPage = index;
    update();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
